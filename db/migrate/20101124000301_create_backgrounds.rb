require "migration_helpers"
class CreateBackgrounds < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :backgrounds do |t|
      t.references :layout
      t.timestamps
    end
    foreign_key :backgrounds,:layout_id,:layouts
  end

  def self.down
    drop_table :backgrounds
  end
end
