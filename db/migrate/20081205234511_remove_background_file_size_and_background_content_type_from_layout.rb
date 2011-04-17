class RemoveBackgroundFileSizeAndBackgroundContentTypeFromLayout < ActiveRecord::Migration
  def self.up
    remove_column(:layouts, :background_content_type, :background_file_size)
  end

  def self.down
    add_column :layouts,:background_content_type,:string
    add_column :layouts,:background_file_size,:string
  end
end
