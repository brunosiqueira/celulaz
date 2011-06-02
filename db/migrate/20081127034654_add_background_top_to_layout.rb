class AddBackgroundTopToLayout < ActiveRecord::Migration
  def self.up
    add_column :layouts, :background_top, :string
  end

  def self.down
    remove_column :layouts, :background_top
  end
end
