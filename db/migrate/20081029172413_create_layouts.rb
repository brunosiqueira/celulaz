require "migration_helpers"
class CreateLayouts < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :layouts do |t|
      t.references :company
      t.string :architecture_type
      t.string :name
      t.string :slogan
      t.string :website
      t.text :presentation_text


      t.string :logo_file_name # Original filename
      t.string :logo_content_type # Mime type
      t.string :logo_file_size # File size in bytes

      t.string :background_file_name # Original filename
      t.string :background_content_type # Mime type
      t.string :background_file_size # File size in bytes

      t.timestamps
    end

    foreign_key(:layouts, :company_id, :companies)

    #adiciona coluna em Color
    add_column :colors, :layout_id, :string
  end

  def self.down
    remove_column :colors, :layout_id
    
    drop_table :layouts
  end
end
