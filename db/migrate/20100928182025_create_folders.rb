class CreateFolders < ActiveRecord::Migration
  def self.up
    create_table :folders do |t|
      t.references :user
      t.integer :parent_id
      t.string :name
    end
  end

  def self.down
    drop_table :folders
  end
end
