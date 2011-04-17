require "migration_helpers"
class CreateNews < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :news do |t|
      t.references :company
      t.text :description

      t.timestamps
    end

    foreign_key(:news, :company_id, :companies)
  end

  def self.down
    drop_table :news
  end
end
