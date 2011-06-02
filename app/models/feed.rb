# == Schema Information
# Schema version: 20110416172335
#
# Table name: feeds
#
#  id           :integer(4)      not null, primary key
#  company_id   :integer(4)
#  feed_item_id :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class Feed < ActiveRecord::Base
  belongs_to :company
  belongs_to :feed_item
end
