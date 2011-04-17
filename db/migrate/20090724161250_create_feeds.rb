class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.references :company
      t.references :feed_item
      t.timestamps
    end
    add_index 'feeds', ['company_id', 'feed_item_id']
  end

  def self.down
    drop_table :feeds
  end
end
