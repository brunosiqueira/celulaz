class AddFileToShipping < ActiveRecord::Migration
  def self.up
    add_column :shippings, :file_name, :string
    add_column :shippings, :file_content_type, :string
    add_column :shippings, :file_data, :binary
  end

  def self.down
    remove_column :shippings, :file_data
    remove_column :shippings, :file_content_type
    remove_column :shippings, :file_name
  end
end
