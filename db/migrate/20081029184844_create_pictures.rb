require 'migration_helpers'
class CreatePictures < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :pictures do |t|
      t.references :component
      t.string :title
      t.text :description
      t.string :picture_file_name
      t.string :picture_content_type
      t.string :picture_file_size

      t.timestamps
    end

    foreign_key :pictures, :component_id, :components
  end

  def self.down
    drop_table :pictures
  end
end
