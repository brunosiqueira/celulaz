class MessageToFriendJob < Struct.new(:message_id)
  def perform
    message = Message.find(message_id)
    MessageMailer.deliver_received(message)
  end
end