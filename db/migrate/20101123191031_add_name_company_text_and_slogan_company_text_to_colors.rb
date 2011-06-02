class AddNameCompanyTextAndSloganCompanyTextToColors < ActiveRecord::Migration
  def self.up
    add_column :colors, :name_company_text, :string, :limit=>7
    add_column :colors, :slogan_company_text, :string, :limit=>7
    add_column :color_templates, :name_company_text, :string, :limit=>7
    add_column :color_templates, :slogan_company_text, :string, :limit=>7
  end


  def self.down
    remove_column :colors, :slogan_company_text
    remove_column :colors, :name_company_text
    remove_column :color_templates, :slogan_company_text
    remove_column :color_templates, :name_company_text
  end
end
