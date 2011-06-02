# == Schema Information
# Schema version: 20110416172335
#
# Table name: layouts
#
#  id                    :integer(4)      not null, primary key
#  company_id            :integer(4)
#  architecture_type     :string(10)
#  name                  :string(255)
#  slogan                :string(255)
#  website               :string(255)
#  presentation_text     :text
#  background_file_name  :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  card1_file_name       :string(255)
#  card1_content_type    :string(255)
#  card1_file_size       :string(255)
#  card2_file_name       :string(255)
#  card2_content_type    :string(255)
#  card2_file_size       :string(255)
#  card3_file_name       :string(255)
#  card3_content_type    :string(255)
#  card3_file_size       :string(255)
#  component_decoration  :string(255)
#  show_name             :boolean(1)
#  show_slogan           :boolean(1)
#  show_logo             :boolean(1)
#  background_top        :string(255)
#  send_to_friend        :integer(4)
#  side_image_url        :string(255)
#  font_colors           :string(255)
#  email                 :string(255)
#  facebook              :string(255)
#  orkut                 :string(255)
#  twitter               :string(255)
#  flickr                :string(255)
#  repeat_background_x   :boolean(1)
#  repeat_background_y   :boolean(1)
#  centralize_background :boolean(1)
#  meta_description      :string(255)
#  meta_keywords         :string(255)
#  analytics             :string(255)
#

class Layout < ActiveRecord::Base
  include HasImage
  
  SLOGAN_DEFAULT = 'Escreva seu slogan aqui!'
  validates_presence_of :name
  belongs_to :company
  
  has_many :components,:dependent=>:destroy

  has_many :component_galleries,:dependent=>:destroy

  has_many :components_expandable,:class_name=>"Component",:dependent=>:destroy,:conditions=>["exists (select * from tab_components as tab_components where tab_components.component_id = components.id) and type in (:types)",{:types=>["ComponentGallery","ComponentText"]}]

  has_many :components_no_tabs,:dependent=>:destroy,:class_name=>"Component", :conditions=>"not exists (select * from tab_components as tab_components where tab_components.component_id = components.id)"

  has_many :tabs,:include=>:components,:dependent=>:destroy,:order=>"tabs.order"

  has_many :tabs_with_components, :class_name=>"Tab", :include => :components, :conditions=>"components.id is not null",:order=>"tabs.order"

  has_one :color,:dependent=>:destroy

  has_many :banners,:dependent=>:destroy

  has_many :background_tops,:dependent=>:destroy
  has_many :backgrounds, :dependent=>:destroy

  has_many :phones, :class_name => "Phone", :as => :owner, :autosave => true, :dependent => :destroy

  before_save :update_my_background_top

  after_create :set_default_color

  has_one :address_site,:class_name=>"Address",:as=>:owner

  has_attached_file :card1, :default_url => "/images/segmentos/icons-person.jpg",
    :styles => {:thumb  => "115x115", :small=>"63x63", :preview=>"300x300" }

  has_attached_file :card2, :default_url => "/images/segmentos/icons-person.jpg",
    :styles => {:thumb  => "115x115", :small=>"63x63", :preview=>"300x300" }

  has_attached_file :card3, :default_url => "/images/segmentos/icons-person.jpg",
    :styles => {:thumb  => "115x115", :small=>"63x63", :preview=>"300x300" }
  
  has_attached_file :my_background_top,
    :styles => {:original=>"960x150#",:small=>"195x60#"}
  
  before_save :correct_images_path

  def default_picture
    "/images/segmentos/#{self.company.segment_file}"
  end

  def default_picture_small
    "/images/segmentos/#{self.company.segment_file}"
  end
  
  def before_save
    self.slogan = nil if SLOGAN_DEFAULT.eql? self.slogan
  end

  def increment_send_to_friend!
    self.update_attribute(:send_to_friend, self.send_to_friend.nil? ? 1 : self.send_to_friend.succ)
  end

  def side_image_original_url
    path = "public/side_image/#{self.company.user.login}/side_image.jpg"
    if File.exist?(path)
      return "side_image/#{self.company.user.login}/side_image.jpg"
    else
      return nil
    end
  rescue
    return nil
  end

  def address
    self.company.address
  end

  #def phones
  #  self.company.phones
  #end

  def state_acronym
    self.company.state_acronym
  end

  def show_card(f,size)
    self.send(f).url(size)
  end

  private

  def correct_images_path
    unless self.background_top.nil?
      self.background_top.gsub!("_small", "")
      self.background_top.gsub!("/small/", "/original/")
    end
    unless self.background_file_name.nil?
      self.background_file_name.gsub!("_small", "")
    end
  end

  def update_my_background_top
#      self.background_tops << b
#      self.background_top =  URI::escape(b.background_top.url(:original))
  end

  def set_default_color
    color = ColorTemplate.first.attributes
    color.delete "id"
    self.update_attribute :color, Color.new(color)
  end
end
