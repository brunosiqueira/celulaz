# == Schema Information
# Schema version: 20110416172335
#
# Table name: subsidiaries
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  enabled    :boolean(1)      default(TRUE), not null
#

class Subsidiary < ActiveRecord::Base
  validates_presence_of :title
  validates_uniqueness_of :title
  has_many :subsidiary_states, :dependent => :destroy
  has_many :states, :through => :subsidiary_states
  has_many :people
end
