class MigrateAddressesToAddressesTable < ActiveRecord::Migration
  def self.up
    Company.transaction do
      Company.find(:all,:include=>:layout).each do |company|
        state = State.find_by_id company.state_id
        company.create_address_business_card :street=>company.street,
          :number=>company.number,
          :complement=>company.complement,
          :zip=>company.zip,
          :neighborhood=>company.neighborhood,
          :city=>company.city,
          :state=>state.acronym
        if company[:type].eql?("CompanyZ")
          company.layout.create_address_site :street=>company.street,
            :number=>company.number,
            :complement=>company.complement,
            :zip=>company.zip,
            :neighborhood=>company.neighborhood,
            :city=>company.city,
            :state=>state.acronym
        end
      end
    end
  end
  
  def self.down
  end
end
