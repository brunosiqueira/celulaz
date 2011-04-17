require 'migration_helpers'
class CreateComponents < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :components do |t|
      t.references :layout
      t.string :type
      t.string :title

      t.string :picture_file_name
      t.string :picture_content_type
      t.string :picture_file_size
      
      t.timestamps
    end
    foreign_key :components, :layout_id, :layouts
  end

  def self.down
    drop_table :components
  end
end
