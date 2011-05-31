class RemoveFontSizeFromDescriptionInComponents < ActiveRecord::Migration
  def self.up
    Component.find(:all).each do |component|
      html = Nokogiri::HTML(component.description)
      html.css('font').each{|f| f.remove_attribute("size")}
      component.update_attribute(:description,html.css("body").inner_html.to_s)
    end

    Picture.find(:all).each do |picture|
      html = Nokogiri::HTML(picture.description)
      html.css('font').each{|f| f.remove_attribute("size")}
      picture.update_attribute(:description,html.css("body").inner_html.to_s)
    end

  end

  def self.down
  end
end
