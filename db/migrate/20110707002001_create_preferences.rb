class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.boolean :site_published
      t.references :user
    end
  end

  def self.down
    drop_table :preferences
  end
end
