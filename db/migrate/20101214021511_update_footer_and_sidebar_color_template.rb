class UpdateFooterAndSidebarColorTemplate < ActiveRecord::Migration
  def self.up
    ColorTemplate.find(:all).each do |color|
      color.update_attributes(:footer_text=>color.text,:sidebar_text=>color.text)
    end
    Color.find(:all).each do |color|
      color.update_attributes(:footer_text=>color.text,:sidebar_text=>color.text)
    end
  end

  def self.down
  end
end
