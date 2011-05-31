class UpdateDefaultsInComponentForm < ActiveRecord::Migration
  def self.up
    ComponentForm.find(:all).each do |component|
      component.update_attributes :show_name=>true,:show_email=>true,:show_phone=>true,:show_address=>true,:show_message=>true
    end
  end

  def self.down
  end
end
