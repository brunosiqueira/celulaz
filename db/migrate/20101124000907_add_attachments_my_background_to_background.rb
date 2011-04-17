class AddAttachmentsMyBackgroundToBackground < ActiveRecord::Migration
  def self.up
    add_column :backgrounds, :my_background_file_name, :string
    add_column :backgrounds, :my_background_content_type, :string
    add_column :backgrounds, :my_background_file_size, :integer
    add_column :backgrounds, :my_background_updated_at, :datetime
  end

  def self.down
    remove_column :backgrounds, :my_background_file_name
    remove_column :backgrounds, :my_background_content_type
    remove_column :backgrounds, :my_background_file_size
    remove_column :backgrounds, :my_background_updated_at
  end
end
