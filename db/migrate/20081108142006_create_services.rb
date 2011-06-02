class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :title, :limit=>30
      t.string :image_path,:limit=>100

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
