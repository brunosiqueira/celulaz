class AddFooterAndSidebarToColor < ActiveRecord::Migration
  def self.up
    add_column :colors, :footer_background, :string,:limit=>7
    add_column :colors, :footer_text, :string,:limit=>7
    add_column :colors, :sidebar_text, :string,:limit=>7
  end

  def self.down
    remove_column :colors, :sidebar_text
    remove_column :colors, :footer_text
    remove_column :colors, :footer_background
  end
end
