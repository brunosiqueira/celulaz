# == Schema Information
# Schema version: 20110416172335
#
# Table name: constants
#
#  id         :integer(4)      not null, primary key
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Constant < ActiveRecord::Base
  validates_presence_of :key
  validates_uniqueness_of :key

  def Constant.find_value_by_key(key)
    constant = Constant.find_by_key key
    constant.nil? ? "" : constant.value
  end
end
