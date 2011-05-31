class CleanRepeatedComponentsInTabComponents < ActiveRecord::Migration
  def self.up
    elements = []
    TabComponent.find(:all,:conditions=>"exists (select 1 from tab_components as tab2 where tab_components.tab_id = tab2.tab_id and tab_components.line = tab2.line and tab_components.column = tab2.column and tab_components.id<>tab2.id and tab_components.updated_at < tab2.updated_at)").each { |item| elements << item }
    TabComponent.destroy(elements)
  end

  def self.down
  end
end
