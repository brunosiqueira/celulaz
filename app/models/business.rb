# == Schema Information
# Schema version: 20110416172335
#
# Table name: businesses
#
#  id                          :integer(4)      not null, primary key
#  company_id                  :integer(4)
#  total                       :integer(4)
#  title                       :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#  business_image_file_name    :string(255)
#  business_image_content_type :string(255)
#  business_image_file_size    :integer(4)
#  business_image_updated_at   :datetime
#  value                       :float
#  per_company                 :integer
#  description                 :text
#  expired_at                  :datetime
#  voucher_expired_at          :date
#  link                        :string
#  status                      :string

class Business < ActiveRecord::Base
  attr_accessor :total_mask
  
  validates_presence_of :company_id, :title, :description, :value, :total, :per_company, :expired_at, :voucher_expired_at, :status
  validates_numericality_of :total, :only_integer=>true
  validates_numericality_of :per_company, :only_integer=>true
  validates_length_of :title, :within => 20..100
  validates_length_of :description, :within => 100..700
  
  belongs_to :company
  has_many :business_companies, :dependent=>:destroy
  has_many :companies, :through => :business_companies

  #custom validations
  validate :validate_available_items
  validate :validate_cupom_and_campaign_dates

  after_save :create_feed_item
  
  STATUS = %w[Rascunho Publicado Finalizado]

  has_attached_file :business_image,
                    :styles => { :small=>"76x62", :big=>"342x279" }
  usar_como_dinheiro :value
  
  def before_destroy
    FeedItem.destroy_all(:item_id=>self.id,:item_type=>"Business")
  end

  def can_buy?(company)
    self.per_company > self.companies.count(:conditions=>{:id=>company.id})
  end
  
  def validate_available_items
    unless self.per_company.nil? || self.total.nil?
      if self.per_company > self.total
        self.errors.add :per_company, 'deve ser menor que a quantidade disponivel'
      end
    end
  end

  def validate_cupom_and_campaign_dates
    unless self.expired_at.nil? || self.voucher_expired_at.nil? 
      if self.expired_at < Time.now
        self.errors.add :expired_at, 'deve ser maior que o horario atual'
      elsif self.expired_at >= self.voucher_expired_at
        self.errors.add :expired_at, 'deve ser menor que a expiração do voucher'
      end
    end
  end
  
  def coupons_available
    self.total - self.business_companies.count
  end

  private

  def create_feed_item
    if self.status == 'Publicado'
      self.company.public_feed_items.create :item=>self,:is_public=>true
    end
  end  
end
