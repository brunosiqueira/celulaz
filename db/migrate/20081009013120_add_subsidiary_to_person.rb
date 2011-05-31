class AddSubsidiaryToPerson < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    add_column :people, :subsidiary_id, :string
  end

  def self.down
    remove_column :people, :subsidiary_id
  end
end
