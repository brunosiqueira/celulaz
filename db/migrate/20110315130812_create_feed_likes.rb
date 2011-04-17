require "migration_helpers"
class CreateFeedLikes < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :feed_likes do |t|
      t.references :company
      t.references :feed_item
      t.timestamps
    end
    foreign_key(:feed_likes, :company_id, :companies)
    foreign_key(:feed_likes, :feed_item_id, :feed_items)
    add_index(:feed_likes, [:feed_item_id,:company_id], :unique=>true)
  end

  def self.down
    drop_table :feed_likes
  end
end
