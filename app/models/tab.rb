# == Schema Information
# Schema version: 20110315144312
#
# Table name: tabs
#
#  id         :integer(4)      not null, primary key
#  layout_id  :integer(4)
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  order      :float
#

class Tab < ActiveRecord::Base
  belongs_to :layout
  has_many :tab_components,:include=>:component,:dependent => :destroy,:order=>"tab_components.line, tab_components.column"
  has_many :components, :through => :tab_components
end
