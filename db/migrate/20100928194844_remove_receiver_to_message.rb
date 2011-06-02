class RemoveReceiverToMessage < ActiveRecord::Migration
  def self.up
    #execute "ALTER TABLE messages MODIFY COLUMN receiver_id INTEGER DEFAULT NULL, DROP INDEX fk_messages_receiver_id"
    #commented for first new deploy
    #remove_column :messages, :receiver_id
  end

  def self.down
    #add_column :messages, :receiver_id, :integer
    #execute "ALTER TABLE messages ADD CONSTRAINT fk_messages_receiver_id FOREIGN KEY (receiver_id) REFERENCES users(id)"
  end
end
