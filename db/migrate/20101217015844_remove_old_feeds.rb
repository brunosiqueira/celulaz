class RemoveOldFeeds < ActiveRecord::Migration
  def self.up
    FeedItem.find(:all,:conditions=>"not exists (select (1) from feeds as f where f.feed_item_id = feed_items.id)").each do |feed_item|
      puts "removendo #{feed_item.id}"
      FeedItem.destroy feed_item.id
    end
  end

  def self.down
  end
end
