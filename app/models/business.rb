class Business < ActiveRecord::Base
  validates_presence_of :total, :company_id
  belongs_to :company
  after_create :create_feed_item
  has_attached_file :business_image,
    :styles => { :small=>"63x63", :big=>"300x300" }

  private
  def create_feed_item
    self.company.public_feed_items.create :item=>self,:is_public=>true
  end
end
