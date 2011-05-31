class AddRepeatBackgroundXAndCentralizeBackgroundAndRepeatBackgroundYInLayouts < ActiveRecord::Migration
  def self.up
    add_column :layouts, :repeat_background_x, :boolean
    add_column :layouts, :repeat_background_y, :boolean
    add_column :layouts, :centralize_background, :boolean
  end

  def self.down
    remove_column :layouts, :repeat_background_x, :repeat_background_y, :centralize_background
  end
end