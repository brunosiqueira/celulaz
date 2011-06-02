class ChangeArchitectureTypeOnLayout < ActiveRecord::Migration
  def self.up
    change_column_default(:layouts, :architecture_type, "horizontal")
  end

  def self.down
  end
end
