class AddParcelToContract < ActiveRecord::Migration
  def self.up
    add_column :contracts, :parcel, :integer
  end

  def self.down
    remove_column :contracts, :parcel
  end
end
