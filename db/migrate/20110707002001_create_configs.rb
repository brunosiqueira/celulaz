class CreateConfigs < ActiveRecord::Migration
  def self.up
    create_table :configs do |t|
      t.boolean :site_published
      t.references :user
    end
  end

  def self.down
    drop_table :configs
  end
end
