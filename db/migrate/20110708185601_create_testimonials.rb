class CreateTestimonials < ActiveRecord::Migration
  def self.up
    create_table :testimonials do |t|
      t.text :content
      t.references :user
      t.integer :sender_id

      t.timestamps
    end
  end

  def self.down
    drop_table :testimonials
  end
end
