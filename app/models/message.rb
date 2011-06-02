# == Schema Information
# Schema version: 20110416172335
#
# Table name: messages
#
#  id               :integer(4)      not null, primary key
#  sender_id        :integer(4)
#  receiver_id      :integer(4)
#  subject          :string(256)
#  body             :text
#  created_at       :datetime
#  updated_at       :datetime
#  sender_name      :string(50)
#  sender_email     :string(50)
#  answer_id        :integer(4)
#  receiver_email   :string(255)
#  first_answer     :boolean(1)
#  deleted_sent_box :boolean(1)
#

class Message < ActiveRecord::Base
  #assocations
  belongs_to :sender, :class_name => "User"
  has_many :message_copies, :dependent=>:destroy
  has_many :recipients, :through => :message_copies
  
  validates_presence_of :body, :subject
  after_create :create_feed_item
  before_create :prepare_copies
  
  attr_accessor  :to # array of people to send to
  attr_accessible :subject, :body, :to, :sender_email
  
  def prepare_copies
    
    return if to.blank?
  
    if self.to.split(",") == ["-1"]
      self.to = []
      sender.company.friends.each do |f|
        self.to.push(f.user_id)
      end
    end
    
    
    self.to.each do |recipient|
      recipient = User.find(recipient)
      message_copies.build(
        :recipient_id => recipient.id,
        :folder_id => recipient.inbox.id)
    end
  end
  
  def is_external?
    sender_email != nil && sender_email != ""
  end

  def sender_name
    is_external? ? sender_email : (sender.nil? ? "Não foi possível localizar o remetente" : sender.login)
  end
  
  def sender_to_s
    self.sender.nil? ? "#{self.sender_name}<#{self.sender_email}> " : self.sender.name
  end

  private
  #TODO: To fix.
  def create_feed_item
    unless self.message_copies.first.nil?
      self.message_copies.first.recipient.company.private_feed_items.create :item => self,:is_public=>false
    end
  end
end
