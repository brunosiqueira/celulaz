class CreateSubsidiaries < ActiveRecord::Migration
  def self.up
    create_table :subsidiaries do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :subsidiaries
  end
end
