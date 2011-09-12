class Testimonial < ActiveRecord::Base
  belongs_to :user
  belongs_to :company, :class_name => "User", :foreign_key=>"sender_id"
  
  validates_length_of :content, :within => 1..500, :on => :create
end
