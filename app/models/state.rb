# == Schema Information
# Schema version: 20110416172335
#
# Table name: states
#
#  id         :integer(4)      not null, primary key
#  acronym    :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class State < ActiveRecord::Base
  validates_presence_of :acronym, :name
  validates_uniqueness_of :acronym, :name
end
