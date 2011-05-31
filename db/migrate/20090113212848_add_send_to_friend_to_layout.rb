class AddSendToFriendToLayout < ActiveRecord::Migration
  def self.up
    add_column :layouts, :send_to_friend, :integer
  end

  def self.down
    remove_column :layouts, :send_to_friend
  end
end
