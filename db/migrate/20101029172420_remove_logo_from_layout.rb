class RemoveLogoFromLayout < ActiveRecord::Migration
  def self.up
    remove_column :layouts, :logo_file_name
    remove_column :layouts, :logo_content_type
    remove_column :layouts, :logo_file_size
  end

  def self.down
    add_column :layouts, :logo_file_name, :string
    add_column :layouts, :logo_content_type, :string
    add_column :layouts, :logo_file_size, :integer
  end
end
