class AddBankCodeAndAgencyAndAccountNumberToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :bank_id, :integer
    add_column :people, :agency, :integer,:limit=>4
    add_column :people, :account_number, :string,:limit=>15
  end

  def self.down
    remove_column :people, :account_number
    remove_column :people, :agency
    remove_column :people, :bank_id
  end
end
