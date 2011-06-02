require "migration_helpers"
class UpdatePicture < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    remove_foreign_key(:pictures, :component_id)
    remove_column(:pictures, :picture_file_size)
    remove_column(:pictures, :picture_content_type)
    remove_column(:pictures, :picture_file_name)
    add_column(:pictures, :photo_file_size,:integer)
    add_column(:pictures, :photo_content_type,:string)
    add_column(:pictures, :photo_file_name,:string)
    add_column(:pictures, :component_type,:string)

  end

  def self.down
    foreign_key(:pictures, :component_id,:components)
    add_column(:pictures, :picture_file_size,:string)
    add_column(:pictures, :picture_content_type,:string)
    add_column(:pictures, :picture_file_name,:string)
    remove_column(:pictures, :photo_file_size)
    remove_column(:pictures, :photo_content_type)
    remove_column(:pictures, :photo_file_name)
    remove_column(:pictures, :component_type)
  end
end
