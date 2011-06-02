# == Schema Information
# Schema version: 20110416172335
#
# Table name: feed_items
#
#  id               :integer(4)      not null, primary key
#  item_type        :string(255)
#  item_id          :integer(4)
#  include_comments :boolean(1)      not null
#  is_public        :boolean(1)      not null
#  created_at       :datetime
#  updated_at       :datetime
#  feed_likes_count :integer(4)      default(0)
#

class FeedItem < ActiveRecord::Base
  has_many :feeds,:dependent=>:destroy
  has_many :feed_likes,:dependent=>:destroy
  has_many :companies_likes,:through => :feed_likes, :class_name=>"Company",:source=>:company
  belongs_to :item, :polymorphic => true
  def partial
    item.class.name.underscore
  end
end
