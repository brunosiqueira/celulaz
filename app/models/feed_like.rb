# == Schema Information
# Schema version: 20110416172335
#
# Table name: feed_likes
#
#  id           :integer(4)      not null, primary key
#  company_id   :integer(4)
#  feed_item_id :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class FeedLike < ActiveRecord::Base
  belongs_to :company
  belongs_to :feed_item,:counter_cache=>true,:touch=>true
  validates_uniqueness_of :company_id,:scope=>[:feed_item_id]
end
