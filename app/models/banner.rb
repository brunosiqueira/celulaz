# == Schema Information
# Schema version: 20110315144312
#
# Table name: banners
#
#  id                        :integer(4)      not null, primary key
#  layout_id                 :integer(4)      not null
#  url                       :string(255)     not null
#  title                     :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  banner_image_file_name    :string(255)
#  banner_image_content_type :string(255)
#  banner_image_file_size    :integer(4)
#  banner_image_updated_at   :datetime
#

class Banner < ActiveRecord::Base
  validates_presence_of :url
  belongs_to :layout
  has_attached_file :banner_image,
    :styles => {:small=>"180x"}
end
