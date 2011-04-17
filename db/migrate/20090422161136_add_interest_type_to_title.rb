class AddInterestTypeToTitle < ActiveRecord::Migration
  def self.up
    add_column :titles, :interest_type, :string,:limit=>1
  end

  def self.down
    remove_column :titles, :interest_type
  end
end
