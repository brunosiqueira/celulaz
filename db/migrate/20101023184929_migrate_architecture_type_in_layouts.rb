class MigrateArchitectureTypeInLayouts < ActiveRecord::Migration
  def self.up
    Layout.find(:all).each do |layout|
      layout.update_attribute(:architecture_type,"horizontal".eql?(layout.architecture_type) ? "6" : "7")
    end
  end

  def self.down
    Layout.find(:all).each do |layout|
      layout.update_attribute(:architecture_type,"6".eql?(layout.architecture_type) ? "horizontal" : "vertical")
    end
  end
end
