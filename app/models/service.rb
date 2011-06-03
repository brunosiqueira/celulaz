# == Schema Information
# Schema version: 20110416172335
#
# Table name: services
#
#  id         :integer(4)      not null, primary key
#  title      :string(30)
#  image_path :string(100)
#  created_at :datetime
#  updated_at :datetime
#

class Service < ActiveRecord::Base
  has_many :company_services, :dependent=>:destroy
  has_many :companies, :through => :company_services
end
