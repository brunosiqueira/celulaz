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
  
  before_save :validate_per_company
  
  def validate_per_company
    debugger
    # verifico se esta company ja adquiriu e comparo com o per_company
    #self.business.per_company
    if self.business.per_company <= self.company.businesses_bought.count
      self.errors.add :company 
      raise
    end
  end
  
end
