class AddFontsToComponents < ActiveRecord::Migration
  def self.up
    add_column :components, :font_colors, :string
  end

  def self.down
    remove_column :components, :font_colors
  end
end
