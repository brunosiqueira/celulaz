class MigrateOldMessagesToNewMessagesFormat < ActiveRecord::Migration
  def self.up
    Message.all.each do |m|
      message = Message.new
      message.body = m.body
      message.to = m.receiver_id.to_s
      message.subject = m.subject
      message.created_at = m.created_at
      message.updated_at = m.updated_at
      message.sender_email = m.sender_email 
      message.sender_id = m.sender_id      
      if m.sender_email == ""
        parameter = {"message" => {"body" => m.body, "to" => [m.receiver_id.to_s], "subject" => m.subject, "created_at" => m.created_at, "updated_at" => m.updated_at, "sender_email" => m.sender_email, "sender_id" => m.sender_id, "receiver_id" => 1}}
        company = Company.find(m.sender_id)
        company.user.sent_messages.build(parameter)
      else
        message.save
      end
      
      m.delete
    end
  end

  def self.down
  end
end
