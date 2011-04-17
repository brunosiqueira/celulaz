class AddUsersConfirmToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :user_create_id, :string
    add_column :people, :user_confirm_id, :string
  end

  def self.down
    remove_column :people, :user_confirm_id
    remove_column :people, :user_create_id
  end
end
