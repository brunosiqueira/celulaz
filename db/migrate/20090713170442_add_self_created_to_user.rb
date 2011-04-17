class AddSelfCreatedToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :self_created, :boolean, :default=>false
  end

  def self.down
    remove_column :users, :self_created
  end
end
