class CreateTemplateTexts < ActiveRecord::Migration
  def self.up
    create_table :template_texts do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :template_texts
  end
end
