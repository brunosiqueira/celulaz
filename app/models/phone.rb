# == Schema Information
# Schema version: 20110315144312
#
# Table name: phones
#
#  id         :integer(4)      not null, primary key
#  company_id :integer(4)
#  person_id  :integer(4)
#  ddd        :integer(3)
#  number     :integer(8)
#  created_at :datetime
#  updated_at :datetime
#  owner_type :string(255)
#  owner_id   :integer(4)
#

class Phone < ActiveRecord::Base
  belongs_to :company
  belongs_to :person
  belongs_to :layout
  
  validates_presence_of :number,:ddd
  validates_numericality_of :number, :allow_nil=>true
  validates_numericality_of :ddd, :allow_nil=>true
end
