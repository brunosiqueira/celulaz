# == Schema Information
# Schema version: 20110416172335
#
# Table name: background_tops
#
#  id                          :integer(4)      not null, primary key
#  layout_id                   :integer(4)
#  background_top_file_name    :string(255)
#  background_top_content_type :string(255)
#  background_top_file_size    :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#

class BackgroundTop < ActiveRecord::Base
  include HasImage

  belongs_to :layout
  has_attached_file :background_top,
    :styles => {:original=>"960x",:small=>"195x60#"}
end
