# == Schema Information
# Schema version: 20110416172335
#
# Table name: folders
#
#  id        :integer(4)      not null, primary key
#  user_id   :integer(4)
#  parent_id :integer(4)
#  name      :string(255)
#

class Folder < ActiveRecord::Base
  acts_as_tree
  belongs_to :user
  has_many :messages, :class_name => "MessageCopy"
end
