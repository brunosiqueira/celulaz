class AddCardPicturesToLayout < ActiveRecord::Migration
  def self.up
    add_column :layouts, :card1_file_name, :string
    add_column :layouts, :card1_content_type, :string
    add_column :layouts, :card1_file_size, :string

    add_column :layouts, :card2_file_name, :string
    add_column :layouts, :card2_content_type, :string
    add_column :layouts, :card2_file_size, :string

    add_column :layouts, :card3_file_name, :string
    add_column :layouts, :card3_content_type, :string
    add_column :layouts, :card3_file_size, :string
  end

  def self.down
    remove_column :layouts, :card1_file_name
    remove_column :layouts, :card1_content_type
    remove_column :layouts, :card1_file_size

    remove_column :layouts, :card2_file_name
    remove_column :layouts, :card2_content_type
    remove_column :layouts, :card2_file_size

    remove_column :layouts, :card3_file_name
    remove_column :layouts, :card3_content_type
    remove_column :layouts, :card3_file_size
  end
end
