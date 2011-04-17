class AddAddressFieldsToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :street, :string
    add_column :people, :number, :integer
    add_column :people, :complement, :string,:limit=>30
    add_column :people, :zip, :string, :limit=>9
    add_column :people, :neighborhood, :string
    add_column :people, :city, :string
    add_column :people, :state, :string, :limit=>2
  end

  def self.down
    remove_column :people, :state
    remove_column :people, :city
    remove_column :people, :zip
    remove_column :people, :complement
    remove_column :people, :number
    remove_column :people, :street
    remove_column :people, :neighborhood
  end
end
