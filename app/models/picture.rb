# == Schema Information
# Schema version: 20110315144312
#
# Table name: pictures
#
#  id                 :integer(4)      not null, primary key
#  component_id       :integer(4)
#  title              :string(255)
#  description        :text
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_size    :integer(4)
#  photo_content_type :string(255)
#  photo_file_name    :string(255)
#  component_type     :string(255)
#

class Picture < ActiveRecord::Base
  include HasImage
  attr_accessor :image_attachment
  before_save :load_picture
  belongs_to :component, :polymorphic => true
  
  has_attached_file :photo,:default_url => "/images/perfil/logo_default.jpg",
    :styles => {
    :thumb=> "100x100#",
    :normal  => "365x215",
    :big =>"700x700"  }

  def photo_thumb
    get_image_url(self.photo,:thumb)
  end

  def photo_original
    get_image_url(self.photo,:normal)
  end

  def photo_big
    get_image_url(self.photo,:big)
  end

  def photo_big_dimension
    get_image_dimension(self.photo,:big)
  end

  def photo_thumb_dimension
    get_image_dimension(self.photo,:thumb)
  end

  def as_json(options={})
    super(:methods=>[:photo_thumb])
  end

  private
  def load_picture
    self.photo = image_attachment unless image_attachment.nil?
  end
end
