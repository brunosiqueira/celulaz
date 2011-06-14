class AddSomeFieldsToBusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :description, :text
    add_column :businesses, :expired_at, :datetime
  end

  def self.down
    remove_column :businesses, :expired_at
    remove_column :businesses, :description
  end
end
