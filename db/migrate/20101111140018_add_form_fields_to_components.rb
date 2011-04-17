class AddFormFieldsToComponents < ActiveRecord::Migration
  def self.up
    add_column :components, :show_name, :boolean
    add_column :components, :show_email, :boolean
    add_column :components, :show_phone, :boolean
    add_column :components, :show_address, :boolean
    add_column :components, :show_message, :boolean
  end

  def self.down
    remove_column :components, :show_message
    remove_column :components, :show_address
    remove_column :components, :show_phone
    remove_column :components, :show_email
    remove_column :components, :show_name
  end
end
