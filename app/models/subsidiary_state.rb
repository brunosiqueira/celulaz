# == Schema Information
# Schema version: 20110416172335
#
# Table name: subsidiary_states
#
#  id            :integer(4)      not null, primary key
#  subsidiary_id :integer(4)
#  state_id      :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

class SubsidiaryState < ActiveRecord::Base
  belongs_to :subsidiary
  belongs_to :state
  has_many :users
end
