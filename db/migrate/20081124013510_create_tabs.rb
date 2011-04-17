require "migration_helpers"
class CreateTabs < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :tabs do |t|
      t.references :layout
      t.string :title

      t.timestamps
    end

    foreign_key :tabs,:layout_id,:layouts
  end

  def self.down
    drop_table :tabs
  end
end
