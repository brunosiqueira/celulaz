class Company::MessageToFriendController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  layout nil

  def create
    @message_to_friend = MessageToFriend.new params[:message_to_friend].merge(:company=>@company)
    if @message_to_friend.valid?
      MessageMailer.delay.deliver_to_friend(@message_to_friend)
      #Delayed::Job.enqueue(EmailNotifyJob.new(@message_to_friend))
    end
    respond_to do |format|
      format.js
    end
  end
end
