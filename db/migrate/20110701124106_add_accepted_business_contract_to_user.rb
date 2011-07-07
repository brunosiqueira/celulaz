class AddAcceptedBusinessContractToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :accepted_business_contract, :boolean
  end

  def self.down
    remove_column :users, :accepted_business_contract
  end
end
