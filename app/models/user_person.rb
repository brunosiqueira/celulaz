# == Schema Information
# Schema version: 20110315144312
#
# Table name: user_people
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)      not null
#  person_id  :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

class UserPerson < ActiveRecord::Base
  belongs_to :user
  belongs_to :person
  validates_uniqueness_of :user_id
end
