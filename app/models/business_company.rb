# == Schema Information
# Schema version: 20110416172335
#
# Table name: business_companies
#
#  id          :integer(4)      not null, primary key
#  company_id  :integer(4)
#  business_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class BusinessCompany < ActiveRecord::Base
  belongs_to :company
  belongs_to :business
  
  validate :validate_per_company, :on => :create
  after_save :check_campaign_status
  
  def validate_per_company
    # verifico se esta company ja adquiriu e comparo com o per_company
    #self.business.per_company
    if self.business.per_company == self.company.business_companies.all(:conditions => ['business_id = ?', self.business_id]).count
      errors.add :company_id, 'Nao pode'
    end
  end
  
  def check_campaign_status
    if self.business.total == self.business.business_companies.count
      self.business.status = 'Finalizado'
      self.business.save
    end
  end
  
end