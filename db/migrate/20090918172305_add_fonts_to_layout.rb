class AddFontsToLayout < ActiveRecord::Migration
  def self.up
    add_column :layouts, :font_colors, :string
  end

  def self.down
    remove_column :layouts, :font_colors
  end
end
