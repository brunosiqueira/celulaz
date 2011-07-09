class AddPromotedAtToFeedItem < ActiveRecord::Migration
  def self.up
    add_column :feed_items, :promoted_at, :datetime
  end

  def self.down
    remove_column :feed_items, :promoted_at
  end
end