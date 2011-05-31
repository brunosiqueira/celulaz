class AddValueToContracts < ActiveRecord::Migration
  def self.up
    add_column :contracts, :value, :float
  end

  def self.down
    remove_column :contracts, :value
  end
end
