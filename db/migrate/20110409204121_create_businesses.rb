require "migration_helpers"
class CreateBusinesses < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :businesses do |t|
      t.references :company
      t.integer :total
      t.string :title

      t.timestamps
    end
    foreign_key(:businesses, :company_id, :companies)
  end

  def self.down
    drop_table :businesses
  end
end
