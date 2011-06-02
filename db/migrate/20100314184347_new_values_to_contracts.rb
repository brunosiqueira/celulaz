class NewValuesToContracts < ActiveRecord::Migration
  def self.up
    Contract.find(:all).each do |c|
      value = !(c.titles.first.nil?) ? c.titles.first.value : (c.payment_type == "anual" ? 450.00 : 50.00)
      c.update_attribute(:value,value)
    end
  end

  def self.down
  end
end
