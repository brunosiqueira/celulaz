require "migration_helpers"
class CreateTitles < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :titles do |t|
      t.references :company
      t.references :contract
      t.date :emission_date
      t.date :due_date
      t.float  :value,:precision=>6,:scale=>2
      t.float :fine_percent,:precision=>4,:scale=>2
      t.integer :days_to_charge_fine, :limit=>2
      t.float :interest_percent,:precision=>4,:scale=>2
      t.float :abatement_value,:precision=>6,:scale=>2
      t.float :discount_value,:precision=>6,:scale=>2
      t.string :discount_type
      t.date :discount_limit_date
      t.string :additional_data,:limit=>800

      t.timestamps
    end
    foreign_key :titles, :company_id,:companies
    foreign_key :titles, :contract_id,:contracts
  end

  def self.down
    drop_table :titles
  end
end
