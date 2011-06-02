class AddSenderNameAndSenderEmailToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :sender_name, :string,:limit=>50
    add_column :messages, :sender_email, :string,:limit=>50
  end

  def self.down
    remove_column :messages, :sender_email
    remove_column :messages, :sender_name
  end
end
