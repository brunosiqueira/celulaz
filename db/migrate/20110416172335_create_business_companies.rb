require "migration_helpers"
class CreateBusinessCompanies < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :business_companies do |t|
      t.references :company
      t.references :business
      t.timestamps
    end
    foreign_key :business_companies, :company_id, :companies
    foreign_key :business_companies, :business_id, :businesses
  end

  def self.down
    drop_table :business_companies
  end
end
