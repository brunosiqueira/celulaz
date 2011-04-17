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

class Component < ActiveRecord::Base
  validates_presence_of :type, :layout_id

  belongs_to :layout
  validates_presence_of :layout_id
  has_one :tab_component,:dependent => :destroy
  has_one :tab,:through => :tab_component
  after_save :create_feed_item
  before_save :parse_colors

  def fonts_colors_list
    self.layout.font_colors.nil? ? [] : self.layout.font_colors.split(';')
  end
  
  private
  def parse_colors
    return if self.description.nil?
    text_list = self.description.split("COLOR=\"#")
    colors = Set.new(self.layout.font_colors.nil? ? [] : self.layout.font_colors.split(";"))
    text_list.each { |color|
      hexa = "0x#{color[0,6]}"
      colors.add(hexa) if hexa.hex > 0
    }
    colors_array = colors.to_a
    self.layout.update_attribute(:font_colors,colors_array.join(";")) unless colors_array.empty?
  end
  
  def create_feed_item
    if layout.company.public_feed_items.exists? [ "item_type=? and is_public=true and feed_items.updated_at>?","Component",DateTime.civil(Time.now.year, Time.now.month, Time.now.day, 0, 0, 0)]
      layout.company.public_feed_items.create :item=>self, :is_public=>true
    end
  end


  def as_json(options={})
    super(options.merge :only=>[:id, :type, :title, :description, :url, :show_name,
        :show_email, :show_phone, :show_address, :show_message])
  end
end

