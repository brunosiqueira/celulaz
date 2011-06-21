# == Schema Information
# Schema version: 20110416172335
#
# Table name: message_copies
#
#  id           :integer(4)      not null, primary key
#  recipient_id :integer(4)
#  message_id   :integer(4)
#  folder_id    :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#  answer_id    :integer(4)
#  read         :boolean(1)
#  deleted      :boolean(1)
#

class MessageCopy < ActiveRecord::Base
  belongs_to :message
  belongs_to :recipient, :class_name => "User"
  belongs_to :folder
  belongs_to :answer, :class_name => "Message", :foreign_key => "answer_id"
  
  delegate :sender, :created_at, :subject, :body, :recipients, :to => :message
  scope_out  :deleted
  scope_out  :not_deleted, :conditions => ["deleted IS NULL OR deleted = ?", false]
  scope_out :unread_messages, :conditions => ["(`read` IS NULL OR `read` = ?) and (deleted is NULL OR deleted = ?)", false, false]
  
  def answered?
    answer_id != nil
  end
  
  def unread?
    !read
  end
end
