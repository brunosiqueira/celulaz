# == Schema Information
# Schema version: 20110315144312
#
# Table name: segments
#
#  id   :integer(4)      not null, primary key
#  name :string(100)
#  file :string(30)
#

class Segment < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :companies
end
