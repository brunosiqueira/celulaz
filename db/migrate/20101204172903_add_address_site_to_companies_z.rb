class AddAddressSiteToCompaniesZ < ActiveRecord::Migration
  def self.up
    CompanyZ.find(:all).each do |company|
      layout = company.layout
      layout.update_attributes :address_site=>Address.new(company.address_business_card.attributes) if layout.address_site.nil?
    end
  end

  def self.down
  end
end
