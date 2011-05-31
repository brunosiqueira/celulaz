require "migration_helpers"
class CreateContracts < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :contracts do |t|
      t.references :company
      t.string :payment_type
      t.date :initial_date
      t.date :end_date
      t.string :status

      t.timestamps
    end
    foreign_key :contracts,:company_id,:companies
  end

  def self.down
    drop_table :contracts
  end
end
