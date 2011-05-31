class ChangeArchitectureTypeInLayouts < ActiveRecord::Migration
  def self.up
    change_column :layouts, :architecture_type,:string,:default=>nil,:limit=>10
  end

  def self.down
    change_column :layouts, :architecture_type,:string,:default=>"horizontal"
  end
end
