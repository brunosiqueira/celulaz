class RemoveMyBackgroundTopFieldsFromLayouts < ActiveRecord::Migration
  def self.up
    remove_column :layouts, :my_background_top_file_name
    remove_column :layouts, :my_background_top_content_type
    remove_column :layouts, :my_background_top_file_size
    remove_column :layouts, :my_background_top_updated_at
  end

  def self.down
    add_column :layouts, :my_background_top_file_name, :string
    add_column :layouts, :my_background_top_content_type, :string
    add_column :layouts, :my_background_top_file_size, :integer
    add_column :layouts, :my_background_top_updated_at, :datetime
  end
end
