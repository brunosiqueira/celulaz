require "migration_helpers"
class CreateTabComponents < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :tab_components do |t|
      t.references :tab
      t.references :component
      t.boolean :full_line
      t.integer :line
      t.integer :column

      t.timestamps
    end
    foreign_key :tab_components, :tab_id, :tabs
    foreign_key :tab_components, :component_id, :components
  end

  def self.down
    drop_table :tab_components
  end
end
