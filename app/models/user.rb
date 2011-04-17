# == Schema Information
# Schema version: 20110315144312
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  login                     :string(255)
#  email                     :string(255)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  activation_code           :string(40)
#  activated_at              :datetime
#  password_reset_code       :string(40)
#  enabled                   :boolean(1)      default(TRUE)
#  type                      :string(255)
#  self_created              :boolean(1)
#  avatar_file_name          :string(255)
#  avatar_content_type       :string(255)
#  avatar_file_size          :integer(4)
#  avatar_updated_at         :datetime
#  domain                    :string(255)
#

require 'digest/sha1'
class User < ActiveRecord::Base

  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 6..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  validates_format_of       :email, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i
  validates_format_of       :login, :with => /^[a-zA-Z][a-z0-9A-Z_\-]+$/
  validate :validate_company_user

  has_many :sellers, :class_name => "Person",:foreign_key=>"user_web_adm_id",
    :conditions=>"not exists (select up.* from user_people as up where people.id = up.person_id)"
  has_many :user_people,:dependent=>:destroy
  has_one :person,:through=>:user_people,:dependent=>:destroy
  has_one :person_old, :class_name => "Person",:dependent=>:destroy
  has_one :user_person,:dependent=>:destroy
  has_one :person,:through=>:user_person,:dependent=>:destroy
  has_one :company,:dependent=>:destroy
  
  # messaging system
  has_many :sent_messages, :class_name => 'Message', :conditions=>["deleted_sent_box = ? or deleted_sent_box is null", false], :foreign_key => 'sender_id',:dependent=>:destroy
  has_many :received_messages, :class_name => 'MessageCopy', :conditions=>["deleted = ? or deleted is null",false],:foreign_key => 'recipient_id',:dependent=>:destroy
  has_many :folders,:dependent=>:destroy
  
  before_create :build_inbox
  
  def inbox
    folders.find_by_name("Inbox")
  end
  
  # TODO => generate new inbox to all users when migrate
  def build_inbox
    folders.build(:name => "Inbox")
  end
  
  # messaging system
  
  #introducing paperclip
  has_attached_file :avatar, 
                    :styles => {:small => "81x81>", :thumb => "33x33#"},
                    :default_url => "/images/admin/userdefault.jpg"

  before_save :encrypt_password
  before_create :make_activation_code

  acts_as_voter

  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :avatar, :domain

  class ActivationCodeNotFound < StandardError; end
  class AlreadyActivated < StandardError
    attr_reader :user, :message;
    def initialize(user, message=nil)
      @message, @user = message, user
    end
  end

  # Finds the user with the corresponding activation code, activates their account and returns the user.
  #
  # Raises:
  #  +User::ActivationCodeNotFound+ if there is no user with the corresponding activation code
  #  +User::AlreadyActivated+ if the user with the corresponding activation code has already activated their account
  def self.find_and_activate!(activation_code)
    raise ArgumentError if activation_code.nil?
    user = find_by_activation_code(activation_code)
    raise ActivationCodeNotFound if !user
    raise AlreadyActivated.new(user) if user.active?
    user.send(:activate!)
    user
  end



  def active?
    # the presence of an activation date means they have activated
    !activated_at.nil?
  end

  # Returns true if the user has just been activated.
  def pending?
    @activated
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  # Updated 2/20/08
  def self.authenticate(login, password)
    u = User.find :first, :conditions => ['login = ? or email = ?', login, login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  def forgot_password
    @forgotten_password = true
    self.make_password_reset_code
  end

  def reset_password
    # First update the password_reset_code before setting the
    # reset_password flag to avoid duplicate email notifications.
    update_attribute(:password_reset_code, nil)
    @reset_password = true
  end

  #used in user_observer
  def recently_forgot_password?
    @forgotten_password
  end

  def recently_reset_password?
    @reset_password
  end

  def self.find_for_forget(email)
    find :first, :conditions => ['email = ? and activated_at IS NOT NULL', email]
  end

  def has_role?(rolename)
    self[:type].eql?(rolename)
  end

  #verifica se o usuário é um administrador
  def is_administrator?
    has_role?(UserAdministrator.name)
  end

  #verifica se o usuário é um administrador web
  def is_web_administrator?
    has_role?(UserWebAdministrator.name) || has_role?(UserWebAdministratorSenior.name) || has_role?(UserWebAdministratorTrainee.name)
  end

  #verifica se o usuário é um gerente geral
  def is_general_manager?
    has_role?(UserGeneralManager.name)
  end

  #verifica se o usuário é uma empresa
  def is_company?
    has_role?(UserCompany.name)
  end

  #verifica se o usuário é um diretor
  def is_director?
    has_role?(UserDirector.name)
  end

  #verifica se o usuário possui um perfil superior ao de uma empresa e de um vendedor
  def is_manager?
    has_role?(UserSegmentManager.name) || is_general_manager?||  is_director?||is_administrator?
  end

  def is_comercial?
    !self.is_company?
  end

  def subusers
    ["UserAdministrator", "UserDirector","UserSupport","UserGeneralManager",
      "UserSegmentManager","UserWebAdministrator","UserWebAdministratorSenior",
      "UserWebAdministratorTrainee"]
  end

  def get_subusers_non_companies(page=1)
    User.paginate :page=>page, :conditions=>['id<>? and type<>?',self.id,UserCompany.name], :order=>"login"
  end

  def get_subusers_companies(page=1)
    UserCompany.paginate :page=>page,:include=>:company,:order=>"companies.razao_social", :conditions=>['users.id<>?',self.id]
  end


  def can_confirm?(person)
    is_superuser?(self,person.user) && not_confirmed?(person) && can_confirm_second?(person)
  end

  #confirma a validade do usuário passado por parâmetro
  def confirm(person)
    person.user_create = self if person.user_create.nil?
    person.user_confirm = self if person.user_confirm.nil?
  end

  def get_pendent_confirm_users(page=1)
    page||=1
    query = "select people.* from people as people where people.user_confirm_id is null and not exists (select up.* from user_people as up where people.id = up.person_id) "
    query << "union  select people.* from people as people inner join user_people as up on people.id = up.person_id inner join users as u on up.user_id = u.id "
    query << "and u.type <> (:company_type) where people.user_confirm_id is null and u.id <> :id order by name"
    Person.paginate_by_sql [query,{:company_type=>UserCompany.name,:id=>self.id}],:page=>page
  end

  def get_pendent_confirm_companies(page=1)
    page||=1
    Company.paginate(:page=>page,
      :joins=>" as companies join user_people as up on companies.user_id = up.user_id join people as people on people.id = up.person_id",
      :order=>"razao_social",
      :conditions=>'people.user_confirm_id is null')
  end

  def confirmed?
    self.person.confirmed? || self.is_administrator? || self.is_director?
  end

  def subsidiary
    self.person.subsidiary
  end

  protected

  # before filter
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end

  def password_required?
    crypted_password.blank? || !password.blank?
  end

  def make_activation_code
    self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

  def make_password_reset_code
    self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

  private

  def validate_company_user
    if company.nil? && is_company?
      errors.add_to_base :company_presence
    end
    if  company && !is_company?
      errors.add_to_base :company_not_allowed
    end
  end

  def activate!
    @activated = true
    self.update_attribute(:activated_at, Time.now.utc)
  end

  def is_superuser?(super_user, user)
    #se for um vendedor está sempre abaixo do usuário corrente
    return true if user.nil? || super_user.is_director?  || super_user.is_administrator? || user[:type] == UserCompany.name
    super_user.subusers.include?(user.class.name) && !super_user[:type].eql?(user[:type])
  end

  def not_confirmed?(person)
    !person.confirmed?
  end

  def can_confirm_second?(person)
    return true if person.user_create.nil?
    return is_superuser?(self,person.user_create)
  end

end

