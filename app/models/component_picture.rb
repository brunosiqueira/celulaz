# == Schema Information
# Schema version: 20110315144312
#
# Table name: components
#
#  id                   :integer(4)      not null, primary key
#  layout_id            :integer(4)
#  type                 :string(255)
#  title                :string(300)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  description          :text
#  url                  :string(255)
#  font_colors          :string(255)
#  show_name            :boolean(1)      default(TRUE)
#  show_email           :boolean(1)      default(TRUE)
#  show_phone           :boolean(1)      default(TRUE)
#  show_address         :boolean(1)      default(TRUE)
#  show_message         :boolean(1)      default(TRUE)
#  show_all_content     :boolean(1)
#

# To change this template, choose Tools | Templates
# and open the template in the editor.

class ComponentPicture < Component
  include HasImage
  attr_accessor :image_attachment

  before_save :load_picture
  after_save :create_feed_item

  has_attached_file :picture,:default_url => "/images/perfil/logo_default.jpg",
    :styles => {
    :big=>"900x400",
    :line=> "750x215",
    :thumb=> "325x215",
    :small  => "120x96" }

  def picture_thumb
    get_image_url(self.picture,:thumb)
  end

  def picture_original
    get_image_url(self.picture,:original)
  end

  def picture_big
    get_image_url(self.picture,:big)
  end

  def picture_small
    get_image_url(self.picture,:small)
  end

  def picture_big_dimension
    get_image_dimension(self.picture,:big)
  end

  def as_json(options={})
    super(:methods=>[:picture_thumb,:picture_small,:picture_big])
  end

  private
  def load_picture
    self.picture = image_attachment unless image_attachment.nil?
  end

end
