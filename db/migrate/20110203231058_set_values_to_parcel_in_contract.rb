class SetValuesToParcelInContract < ActiveRecord::Migration
  def self.up
    Contract.find(:all).each do |contract|
      if contract.payment_type == "Anual"
        contract.update_attribute :parcel, 1
      else
        contract.update_attribute :parcel, 12
      end
    end
  end

  def self.down
  end
end
