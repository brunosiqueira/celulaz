# == Schema Information
# Schema version: 20110315144312
#
# Table name: banks
#
#  id         :integer(4)      not null, primary key
#  code       :integer(3)      not null
#  name       :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

class Bank < ActiveRecord::Base
  validates_presence_of :name
end
