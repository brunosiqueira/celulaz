require "migration_helpers"
class CreateCompanyServices < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :company_services do |t|
      t.references :company
      t.references :service
      t.timestamps
    end
    foreign_key :company_services, :company_id, :companies
    foreign_key :company_services, :service_id, :services
    add_index(:company_services, [:company_id,:service_id], :unique=>true)
  end

  def self.down
    drop_table :company_services
  end
end
