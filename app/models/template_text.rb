# == Schema Information
# Schema version: 20110315144312
#
# Table name: template_texts
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class TemplateText < ActiveRecord::Base
  validates_presence_of :title
end
