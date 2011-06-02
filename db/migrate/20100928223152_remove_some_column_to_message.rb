class RemoveSomeColumnToMessage < ActiveRecord::Migration
  def self.up
    #commented for first new deploy
    #remove_column :messages, :receiver_email
    #remove_column :messages, :first_answer
    #remove_column :messages, :answer_id
    #remove_column :messages, :sender_name
  end

  def self.down
    #add_column :messages, :receiver_email, :string
    #add_column :messages, :first_answer, :boolean
    #add_column :messages, :answer_id, :integer
    #add_column :messages, :sender_name, :string
  end
end
