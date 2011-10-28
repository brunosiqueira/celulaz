# == Schema Information
# Schema version: 20110416172335
#
# Table name: companies
#
#  id                        :integer(4)      not null, primary key
#  user_id                   :integer(4)
#  cnpj                      :string(18)
#  razao_social              :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  person_id                 :string(255)
#  payment_type              :string(10)      default("mensal")
#  segment_id                :string(255)
#  state_id                  :string(255)
#  type                      :string(10)      default("CompanyS"), not null
#  informal                  :boolean(1)
#  drawee_code               :string(15)
#  register_number           :string(255)
#  profile_logo_file_name    :string(255)
#  profile_logo_content_type :string(255)
#  profile_logo_file_size    :integer(4)
#  profile_logo_updated_at   :datetime
#

class Company < ActiveRecord::Base
  acts_as_voteable
  attr_accessor :value,:parcel
  validates_presence_of :razao_social,:type,:segment_id
  validates_uniqueness_of :drawee_code,:allow_nil=>true
  usar_como_cnpj :cnpj
  has_many :feed_likes,:dependent=>:destroy
  belongs_to :user
  belongs_to :seller, :class_name=>"Person",:foreign_key=>"person_id"  
  belongs_to :segment

  validates_presence_of  :segment

  has_many :businesses, :dependent=>:destroy

  has_many :business_companies, :dependent=>:destroy
  has_many :businesses_bought, :through => :business_companies,:source=>:business
  has_many :feeds,:dependent=>:destroy
  has_many :news,:dependent=>:destroy
  has_many :feed_items, :through => :feeds, :order => 'feed_items.updated_at desc'
  has_many :private_feed_items, :through => :feeds, :source => :feed_item, :conditions => {:is_public => false}, :order => 'feed_items.updated_at desc'
  has_many :public_feed_items, :through => :feeds, :source => :feed_item, :conditions => {:is_public => true}, :order => 'feed_items.updated_at desc'

  has_many :contracts,:order=>"created_at DESC",:dependent => :destroy
  has_many :open_contracts,:class_name=>"Contract",:order=>"created_at DESC",:dependent => :destroy,:conditions=>["status=?","Aberto"]
  has_many :titles,:dependent => :destroy
  has_many :titles_shipped,:class_name=>"Title",:dependent => :destroy,:conditions=>["status <> ? ",Title::STATUS_DIGITADO]
  has_many :titles_visible,:class_name=>"Title",:dependent => :destroy,:conditions=>["(status = ? or status <> ?) and our_number is not null",Title::STATUS_LIQUIDADO,Title::STATUS_BAIXADO]
  has_many :titles_not_payed,:class_name=>"Title",:dependent => :destroy,:conditions=>["status <> ?  and due_date < ? and our_number is not null",Title::STATUS_LIQUIDADO,Time.now]
  
  has_one :layout,:dependent=>:destroy

  has_many :phones, :class_name => "Phone", :as => :owner, :autosave => true, :dependent => :destroy
  
  has_one :address_business_card,:class_name=>"Address",:as=>:owner,:autosave=>true,:dependent=>:destroy

  has_many :company_services,:dependent=>:destroy
  has_many :services , :through => :company_services,:uniq=>true
  has_many :origins_relationships, :class_name=>"CompanyRelationship", :foreign_key=>"company_destiny_id",:order=>"updated_at desc",:dependent=>:destroy
  has_many :origins, :through => :origins_relationships
  has_many :destinies_relationships, :class_name=>"CompanyRelationship", :foreign_key=>"company_origin_id",:order=>"updated_at desc",:dependent=>:destroy
  has_many :destinies, :through => :destinies_relationships


  #relacionamentos pendentes de confirmação
  has_many :pendent_relationships, :class_name=>"CompanyRelationship", :foreign_key=>"company_destiny_id",:dependent=>:destroy,:conditions=>["confirmed=?",false]
  has_many :pendents, :through => :pendent_relationships,:source=>"origin"

  has_attached_file :profile_logo, :default_url=>"/images/segmentos/icons-person.jpg",
    :styles => {:big=> "160x180#", :small=>"63x63#", }

  before_create :generate_drawee_code

  after_create :generate_contract, :generate_layout, :generate_z_structure,:create_feed_item
  
  define_index do
    indexes :razao_social
    indexes segment.name, :as=>:segment_name
    indexes segment_id, :as=>:segment_id
    indexes layout.name, :as => :layout_name,:sortable => true
    indexes layout.slogan, :as => :layout_slogan
    indexes layout.website, :as => :layout_website
    indexes layout.presentation_text, :as => :layout_presentation_text
    indexes address_business_card.state, :as=>:address_state,:sortable => true
    indexes address_business_card.city, :as=>:address_city
    indexes address_business_card.zip, :as=>:address_zip
    indexes address_business_card.number, :as=>:address_number
    indexes address_business_card.street, :as=>:address_street
    indexes address_business_card.neighborhood, :as=>:address_neighborhood

    has updated_at,:sortable => true
  end

  def has_origins?(company)
    CompanyRelationship.count(:conditions=>{:company_destiny_id=>self.id,:company_origin_id=>company.id})>0
  end

  def has_destinies?(company)
    CompanyRelationship.count(:conditions=>{:company_origin_id=>self.id,:company_destiny_id=>company.id})>0
  end

  def web_adm
    self.user.person.web_adm
  end

  def name
    self.layout ? self.layout.name : self.razao_social
  end

  def person_name
    person.name
  end

  # TODO: refatorar criando um site_enable boolean para controle de visualizacao
  def site_enable?
    self[:type] == "CompanyZ" && !self.layout.architecture_type.nil?
  end


  def person
    user ? user.person : nil
  end


  def friends_count
    query = "SELECT COUNT(1) FROM ( SELECT companies.id as id
 FROM companies as companies
 JOIN company_relationships as destinies
 ON (companies.id = destinies.company_origin_id and confirmed=true)
 WHERE (destinies.company_destiny_id=#{id.to_s})
 UNION SELECT companies.id as id
 FROM companies as companies
 JOIN company_relationships as origins
 ON (companies.id = origins.company_destiny_id and confirmed=true)
 WHERE (origins.company_origin_id=#{id.to_s}) group by id ) as count_friends"
    Company.count_by_sql(query)
  end

  def friends(page=1, per_page=5, conditions=nil)
    query = "
    SELECT companies.* FROM companies as companies 
    JOIN company_relationships as destinies 
    ON (companies.id = destinies.company_origin_id and confirmed=true) 
    JOIN layouts as layouts
    ON (companies.id = layouts.company_id)
    WHERE (destinies.company_destiny_id=#{self.id.to_s})"
    query << " AND #{conditions}" unless conditions.nil?
    query << " 
    UNION SELECT companies.* 
    FROM companies as companies 
    JOIN company_relationships as origins 
    ON (companies.id = origins.company_destiny_id and confirmed=true) 
    JOIN layouts as layouts
    ON (companies.id = layouts.company_id)
    WHERE (origins.company_origin_id=#{self.id.to_s})"
    query << " AND #{conditions}" unless conditions.nil?
    
    Company.paginate_by_sql(query, :page => page, :per_page => per_page, :order => "razao_social")
  end
  
  # para o componente amigos da home logada
  def random_friends
    query = "
    (SELECT companies.* FROM companies as companies 
    JOIN company_relationships as destinies 
    ON (companies.id = destinies.company_origin_id and confirmed=true) 
    JOIN layouts as layouts
    ON (companies.id = layouts.company_id)
    WHERE (destinies.company_destiny_id=#{self.id.to_s}))"
    query << " 
    UNION (SELECT companies.* 
    FROM companies as companies 
    JOIN company_relationships as origins 
    ON (companies.id = origins.company_destiny_id and confirmed=true) 
    JOIN layouts as layouts
    ON (companies.id = layouts.company_id)
    WHERE (origins.company_origin_id=#{self.id.to_s}))"
    query << " order by rand()"
    Company.paginate_by_sql(query, :page => 1, :per_page => 6)
  end
  
  # metodo para listar os amigos ao enviar mensagens
  def auto_suggest_friends
    query = "
    SELECT companies.* FROM companies as companies 
    JOIN company_relationships as destinies 
    ON (companies.id = destinies.company_origin_id and confirmed=true) 
    WHERE (destinies.company_destiny_id=#{self.id.to_s})"
    query << " 
    UNION SELECT companies.* 
    FROM companies as companies 
    JOIN company_relationships as origins 
    ON (companies.id = origins.company_destiny_id and confirmed=true) 
    WHERE (origins.company_origin_id=#{self.id.to_s})"
    
    Company.find_by_sql query
  end
  
  def friend_requests
    query = "
    SELECT companies.* FROM companies as companies 
    JOIN company_relationships as destinies 
    ON (companies.id = destinies.company_origin_id and confirmed=false) 
    WHERE (destinies.company_destiny_id=#{self.id.to_s})"
    Company.find_by_sql query
  end
  
  def friends_suggestions
    my_friends = self.friends(1,10)
    fs = []
    for mf in my_friends
      for of in mf.friends
        fs.push(of) unless of.id == self.id || my_friends.include?(of)
      end
    end
    return fs.uniq
  end
  
  def validate_friend_requests(status=nil, company_origin_id=nil)
    if status == "true"
      if relationship = self.origins_relationships.find_by_company_origin_id(company_origin_id)
        relationship.update_attributes(:confirmed=>true)
      end
      #      sql = "UPDATE company_relationships SET confirmed=TRUE WHERE company_destiny_id=#{self.id.to_s} AND company_origin_id=#{company_origin_id}"
    elsif status == "false"
      if relationship = self.origins_relationships.find_by_company_origin_id(company_origin_id)
        self.origins_relationships.delete relationship
      end
      #      sql = "DELETE FROM company_relationships WHERE company_destiny_id=#{self.id.to_s} AND company_origin_id=#{company_origin_id}"
    end
    #    ActiveRecord::Base.connection.execute(sql)
  end

  def segment_file
    segment.attributes["file"]
  end

  def segment_name
    segment.name
  end

  def document
    (self.cnpj.nil? || self.cnpj.to_s.blank?)  ? self.register_number : self.cnpj
  end

  def z?
    self[:type] == CompanyZ.name
  end

  def to_company_z
    if (!self.informal && (self.cnpj.nil? || self.cnpj.to_s.blank?)) && (self.register_number.nil? || self.register_number.blank?)
      self.errors.add :cnpj,:blank
      raise
    elsif self.open_contracts.empty? && (self.value.nil? || self.parcel.nil?)
      self.errors.add :parcel,:blank
    else
      @changed_to_z = true
      self.type = CompanyZ.name
      self.save!
      generate_contract unless self.open_contracts.empty?
    end
  end

  def to_company_s
    @changed_to_s = true
    self.update_attribute :type, CompanyS.name
  end

  def changed_to_s?
    @changed_to_s
  end

  def changed_to_z?
    @changed_to_z
  end

  #Reinicia informações da empresa necessárias para novas regras de criação
  def refresh_data!
    generate_drawee_code
  end
  
  def to_param
    "#{id}-#{razao_social.gsub(/[^a-z0-9]+/i, '-')}"
    #end
  end

  def count_visitors(local,time)
    url = nil
    case local
    when :site
      url = "/z/#{self.user.login}"
    when :business_card
      url = "/business_cards/#{self.to_param}"
    when :profile
      url = "/system_modules/profiles/#{self.to_param}"
    end
    start = time == :today ? Time.now.utc.beginning_of_day : Time.now.utc - 1.month
    Visit.count :conditions=>["request_url=? and created_at>? and created_at<?",url,start,Time.now.utc]
  end
  
  private
  
  def is_formal_company
    !self.informal && self.register_number.nil?
  end

  def generate_drawee_code
    prefix = I18n.t("scope_name") == "autonomoz" ? "AZ" : "SZ"
    number = "#{prefix}#{rand(999999)}"
    while !Company.find_by_drawee_code(number).nil? do
      number = "#{prefix}#{rand(999999)}"
    end
    self.drawee_code = number
  end

  def generate_contract
    if self[:type] == CompanyZ.name
      self.contracts << Contract.new(:value=>self.value ,:initial_date=>self.created_at ,:end_date=>(self.created_at + 1.year),:parcel=>(self.parcel))
    end
  end

  def generate_layout
    params = {:name=>self.razao_social}
    if self[:type] == "CompanyZ" && !self.address_business_card.nil?
      params.merge! :address_site=>Address.new(self.address_business_card.attributes)
    end
    self.create_layout(params)
  end

  def generate_z_structure
    layout =self.layout
    layout.tabs.create!(:title=>"Home") if self.z?
    color_template = ColorTemplate.find :first
    layout.create_color(color_template.attributes)
  end

  def create_feed_item
    self.public_feed_items.create :item=>self,:is_public=>true
  end
end
