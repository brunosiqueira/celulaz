class AddShowFieldsToLayout < ActiveRecord::Migration
  def self.up
    add_column :layouts, :show_name, :boolean
    add_column :layouts, :show_slogan, :boolean
    add_column :layouts, :show_logo, :boolean
  end

  def self.down
    remove_column :layouts, :show_logo
    remove_column :layouts, :show_slogan
    remove_column :layouts, :show_name
  end
end
