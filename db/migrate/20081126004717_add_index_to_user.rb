class AddIndexToUser < ActiveRecord::Migration
  def self.up
    add_index(:users, :login, :unique=>:true)
    add_index(:users, :email, :unique=>:true)
  end

  def self.down
    remove_index :users, :column=>:login
    remove_index :users, :column=>:email
  end
end
