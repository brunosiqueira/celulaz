class AddFeedLikesCountToFeedItem < ActiveRecord::Migration
  def self.up
    add_column :feed_items, :feed_likes_count, :integer,:default=>0
    FeedItem.reset_column_information
  end

  def self.down
    remove_column :feed_items, :feed_likes_count
  end
end
