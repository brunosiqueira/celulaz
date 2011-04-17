class AddStateToCompanyAndPerson < ActiveRecord::Migration
  def self.up
    add_column :companies, :state_id, :string
    add_column :people, :state_id, :string
  end

  def self.down
    remove_column :companies, :state_id
    remove_column :people, :state_id
  end
end
