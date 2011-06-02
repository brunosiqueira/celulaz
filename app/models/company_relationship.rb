# == Schema Information
# Schema version: 20110416172335
#
# Table name: company_relationships
#
#  id                 :integer(4)      not null, primary key
#  company_origin_id  :integer(4)      not null
#  company_destiny_id :integer(4)      not null
#  confirmed          :boolean(1)      not null
#  created_at         :datetime
#  updated_at         :datetime
#

class CompanyRelationship < ActiveRecord::Base
  validate :companies_are_different
  
  validates_uniqueness_of :company_destiny_id, :scope=>:company_origin_id,:on=>:create
  validates_uniqueness_of :company_origin_id, :scope=>:company_destiny_id,:on=>:create

  belongs_to :destiny,:class_name=>"Company",:foreign_key=>"company_destiny_id"
  belongs_to :origin,:class_name=>"Company",:foreign_key=>"company_origin_id"
  after_update :create_feed_item
  def confirm!
    self.confirmed = true
  end

  private
  def companies_are_different
    if destiny.id.equal? origin.id
      self.errors.add_to_base :self_relationship
    end
  end

  def create_feed_item
    feed_item = FeedItem.create(:item => self,:is_public=>true)
    destiny.feed_items << feed_item
    origin.feed_items << feed_item
  end
end
