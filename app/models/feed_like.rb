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

  # managing promoted_at
  #after_save :update_promoted_at
  #before_destroy :returning_promoted_at
  
  def update_promoted_at
    self.feed_item.promoted_at = self.updated_at
    self.save
  end
  
  def returning_promoted_at
    debugger
  end
  
end
