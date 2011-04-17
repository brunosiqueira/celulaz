class AddEnabledToSubsidiaries < ActiveRecord::Migration
  def self.up
    add_column :subsidiaries, :enabled, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :subsidiaries, :enabled
  end
end
