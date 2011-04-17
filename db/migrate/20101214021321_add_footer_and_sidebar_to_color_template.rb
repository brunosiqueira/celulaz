class AddFooterAndSidebarToColorTemplate < ActiveRecord::Migration
  def self.up
    add_column :color_templates, :sidebar_text, :string,:limit=>7
    add_column :color_templates, :footer_background, :string,:limit=>7
    add_column :color_templates, :footer_text, :string,:limit=>7
  end

  def self.down
    remove_column :color_templates, :footer_text
    remove_column :color_templates, :footer_background
    remove_column :color_templates, :sidebar_text
  end
end
