# == Schema Information
# Schema version: 20110416172335
#
# Table name: people
#
#  id              :integer(4)      not null, primary key
#  user_id         :integer(4)
#  name            :string(255)
#  cpf             :string(14)
#  rg              :string(50)
#  rg_exp          :string(50)
#  rg_exp_date     :date
#  date_birth      :date
#  created_at      :datetime
#  updated_at      :datetime
#  subsidiary_id   :string(255)
#  user_create_id  :string(255)
#  user_confirm_id :string(255)
#  state_id        :string(255)
#  user_web_adm_id :string(255)
#  bank_id         :integer(4)
#  agency          :integer(4)
#  account_number  :string(15)
#

class Person < ActiveRecord::Base
  usar_como_cpf :cpf
  validates_presence_of :cpf, :unless=>:person_from_company_s
  validates_presence_of :name
  validates_presence_of :subsidiary_id, :if=>:has_subsidiary
  
  #belongs_to :user
  has_many :user_people,:dependent=>:destroy
  has_many :users,:through=>:user_people,:dependent=>:destroy

  belongs_to :web_adm, :class_name => "User", :foreign_key => "user_web_adm_id"
  
  belongs_to :user_create, :class_name=>"User",:foreign_key=>"user_create_id"

  belongs_to :user_confirm, :class_name=>"User", :foreign_key=>"user_confirm_id"
  
  belongs_to :subsidiary

  has_many :companies,:dependent => :nullify

  has_many :phones, :class_name => "Phone", :as => :owner, :autosave => true, :dependent => :destroy

  belongs_to :bank

  belongs_to :state

  def user
    users.empty? ? nil : users.first
  end

  def confirmed?
    !self.user_confirm_id.nil?
  end

  def state_acronym
    state ? state.acronym : ''
  end

  def subsidiary_title
    logger.info("##People_ID:"+id.to_s+" "+name+"\n")
    !subsidiary.nil? ? subsidiary.title : ''
  end

  private
  def has_subsidiary
    user.nil? || user.need_subsidiary?
  end

  def person_from_company
    is_company = false
    self.users.each { |user|  is_company = true if user[:type].eql?(UserCompany.name)}
    return is_company
  end

  def person_from_company_s
    return false if self.users.empty?
    unless self.new_record?
      count = UserCompany.count(:include=>[:company,:user_people],:conditions=>["companies.type = ? and user_people.person_id=?",CompanyS.name,self.id])
      return count == 1
    else
      user = self.users.first
      return user.is_company? && !user.company.z?
    end
  end

end
