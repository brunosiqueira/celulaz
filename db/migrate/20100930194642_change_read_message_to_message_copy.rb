class ChangeReadMessageToMessageCopy < ActiveRecord::Migration
  def self.up
    remove_column :messages, :read
    add_column :message_copies, :read, :boolean
  end

  def self.down
    add_column :messages, :read, :boolean
    remove_column :message_copies, :read
  end
end
