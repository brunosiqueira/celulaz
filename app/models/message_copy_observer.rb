class MessageCopyObserver < ActiveRecord::Observer
  def after_create(message)
    MessageMailer.delay.deliver_received(message)
    #    Delayed::Job.enqueue(MessageToFriendJob.new(message.id))
  end
end
