class MigratePhonesToRespectiveModels < ActiveRecord::Migration
  def self.up
    Phone.all.each do |p|
      if p.company
        p.owner_type = "Company"
        p.owner_id = p.company.id
        p.save
        
        new_phone = Phone.new
        new_phone.ddd = p.ddd
        new_phone.number = p.number
        new_phone.owner_type = "Layout"
        new_phone.owner_id = p.company.layout.id
        new_phone.save
      else
        p.owner_type = "Person"
        p.owner_id = p.person.id
        p.save
      end
      
      
    end
  end

  def self.down
  end
end
