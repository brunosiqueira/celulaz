class AddReceiverEmailToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :receiver_email, :string
  end

  def self.down
    remove_column :messages, :receiver_email
  end
end
