require "migration_helpers"
class CreateCompanyRelationships < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :company_relationships do |t|
      t.integer :company_origin_id,:null=>false
      t.integer :company_destiny_id,:null=>false
      t.boolean :confirmed, :default=>false,:null=>false
      t.timestamps
    end
    foreign_key :company_relationships,:company_origin_id,:companies
    foreign_key :company_relationships,:company_destiny_id,:companies
  end

  def self.down
    drop_table :company_relationships
  end
end
