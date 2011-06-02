# == Schema Information
# Schema version: 20110416172335
#
# Table name: company_services
#
#  id         :integer(4)      not null, primary key
#  company_id :integer(4)
#  service_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class CompanyService < ActiveRecord::Base
  belongs_to :company
  belongs_to :service
end
