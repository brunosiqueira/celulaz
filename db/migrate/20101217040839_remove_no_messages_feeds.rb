class RemoveNoMessagesFeeds < ActiveRecord::Migration
  def self.up
    FeedItem.find(:all,:conditions=>{:item_type=>"Message"}).each do |feed_item|
      company = feed_item.feeds.first.company
      user = company.user
      if user.received_messages.find_by_id(feed_item.item_id).nil?
        puts "removendo #{feed_item.id}"
        FeedItem.destroy feed_item.id
      end
    end
  end

  def self.down
  end
end
