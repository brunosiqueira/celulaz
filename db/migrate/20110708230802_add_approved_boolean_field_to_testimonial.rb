class AddApprovedBooleanFieldToTestimonial < ActiveRecord::Migration
  def self.up
    add_column :testimonials, :approved, :boolean
  end

  def self.down
    remove_column :testimonials, :approved
  end
end
