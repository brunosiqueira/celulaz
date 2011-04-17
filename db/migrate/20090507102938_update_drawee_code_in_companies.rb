class UpdateDraweeCodeInCompanies < ActiveRecord::Migration
  def self.up
    Company.find(:all).each { |company|
      company.refresh_data!
      company.save
    }
  end

  def self.down
  end
end
