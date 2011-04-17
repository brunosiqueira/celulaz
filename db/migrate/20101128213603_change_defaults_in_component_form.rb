class ChangeDefaultsInComponentForm < ActiveRecord::Migration
  def self.up
    change_column_default(:components, :show_name, true)
    change_column_default(:components, :show_email, true)
    change_column_default(:components, :show_phone, true)
    change_column_default(:components, :show_address, true)
    change_column_default(:components, :show_message, true)
  end

  def self.down
  end
end
