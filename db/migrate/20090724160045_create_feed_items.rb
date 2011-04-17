class CreateFeedItems < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.string :item_type
      t.integer :item_id
      t.boolean  :include_comments, :default => false, :null => false
      t.boolean  :is_public,        :default => false, :null => false
      t.timestamps
    end
    add_index :feed_items, [:item_id, :item_type]
  end

  def self.down
    drop_table :feed_items
  end
end
