class AddSegmentIdToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :segment_id, :string
  end

  def self.down
    remove_column :companies, :segment_id
  end
end
