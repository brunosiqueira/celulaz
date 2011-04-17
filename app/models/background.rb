# == Schema Information
# Schema version: 20110315144312
#
# Table name: backgrounds
#
#  id                         :integer(4)      not null, primary key
#  layout_id                  :integer(4)
#  created_at                 :datetime
#  updated_at                 :datetime
#  my_background_file_name    :string(255)
#  my_background_content_type :string(255)
#  my_background_file_size    :integer(4)
#  my_background_updated_at   :datetime
#

class Background < ActiveRecord::Base
  belongs_to :layout
  has_attached_file :my_background, :styles => {:small=>"68x61" }
end
