# == Schema Information
# Schema version: 20110416172335
#
# Table name: news
#
#  id          :integer(4)      not null, primary key
#  company_id  :integer(4)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class News < ActiveRecord::Base
  belongs_to :company
  after_create :create_feed_item
  private
  def create_feed_item
    self.company.public_feed_items.create :item => self,:is_public=>true
  end
end
