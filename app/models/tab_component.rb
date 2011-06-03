# == Schema Information
# Schema version: 20110416172335
#
# Table name: tab_components
#
#  id           :integer(4)      not null, primary key
#  tab_id       :integer(4)
#  component_id :integer(4)
#  full_line    :boolean(1)
#  line         :integer(4)
#  column       :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class TabComponent < ActiveRecord::Base
  validates_presence_of :component_id,:tab_id
  belongs_to :component
  belongs_to :tab
end
