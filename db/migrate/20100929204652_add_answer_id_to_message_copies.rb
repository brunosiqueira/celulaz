class AddAnswerIdToMessageCopies < ActiveRecord::Migration
  def self.up
    add_column :message_copies, :answer_id, :integer
  end

  def self.down
    remove_column :message_copies, :answer_id
  end
end
