class AddAddressToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :street, :string
    add_column :companies, :number, :integer
    add_column :companies, :complement, :string,:limit=>30
    add_column :companies, :zip, :string,:limit=>9
    add_column :companies, :neighborhood, :string
    add_column :companies, :city, :string
    add_column :companies, :state, :string, :limit=>2
  end

  def self.down
    remove_column :companies, :neighborhood
    remove_column :companies, :state
    remove_column :companies, :city
    remove_column :companies, :zip
    remove_column :companies, :complement
    remove_column :companies, :number
    remove_column :companies, :street
  end
end
