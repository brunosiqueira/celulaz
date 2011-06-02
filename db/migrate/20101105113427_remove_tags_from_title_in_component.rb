class RemoveTagsFromTitleInComponent < ActiveRecord::Migration
  def self.up
    Component.find(:all).each do |component|
      component.update_attribute(:title,Nokogiri::HTML(component.title).inner_text)
    end
    Picture.find(:all).each do |picture|
      picture.update_attribute(:title,Nokogiri::HTML(picture.title).inner_text)
    end
  end

  def self.down
  end
end
