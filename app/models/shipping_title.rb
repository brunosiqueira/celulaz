# == Schema Information
# Schema version: 20110315144312
#
# Table name: shipping_titles
#
#  id          :integer(4)      not null, primary key
#  shipping_id :integer(4)
#  title_id    :integer(4)
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class ShippingTitle < ActiveRecord::Base
  belongs_to :title
  belongs_to :shipping
  validates_presence_of :title_id,:shipping_id
  validates_presence_of :status,:on=>:update
  validates_inclusion_of :status, :in=>Title.status_list,:allow_nil=>true

  before_create :update_status_selecionado
  before_destroy :update_status_digitado

  private
  def update_status_selecionado
    self.title.select!
    self.status = self.title.status
  end

  def update_status_digitado
    self.title.restart!
  end
end
