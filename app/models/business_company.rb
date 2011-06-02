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
  belongs_to :business,:include=>:layout
end
