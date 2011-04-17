class RemoveAddressFromCompanyAndPerson < ActiveRecord::Migration
  def self.up
    remove_column :companies, :neighborhood
    remove_column :companies, :state
    remove_column :companies, :city
    remove_column :companies, :zip
    remove_column :companies, :complement
    remove_column :companies, :number
    remove_column :companies, :street
    remove_column :people, :state
    remove_column :people, :city
    remove_column :people, :zip
    remove_column :people, :complement
    remove_column :people, :number
    remove_column :people, :street
    remove_column :people, :neighborhood
  end

  def self.down
    add_column :companies, :street, :string
    add_column :companies, :number, :integer
    add_column :companies, :complement, :string,:limit=>30
    add_column :companies, :zip, :string,:limit=>9
    add_column :companies, :neighborhood, :string
    add_column :companies, :city, :string
    add_column :companies, :state, :string, :limit=>2
    add_column :people, :street, :string
    add_column :people, :number, :integer
    add_column :people, :complement, :string,:limit=>30
    add_column :people, :zip, :string, :limit=>9
    add_column :people, :neighborhood, :string
    add_column :people, :city, :string
    add_column :people, :state, :string, :limit=>2
  end
end
