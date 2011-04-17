class AddPersonIdToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :person_id, :string
  end

  def self.down
    remove_column :companies, :person_id
  end
end
