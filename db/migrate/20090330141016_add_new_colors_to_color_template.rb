class AddNewColorsToColorTemplate < ActiveRecord::Migration
  def self.up
    ColorTemplate.create :name=>'FF0000', :slogan=>'FFFFFF', :title=>'CC3333', :subtitle=>'FFFF33', :checked_menu=>'FF9933', :unchecked_menu=>'990000', :background_menu=>'990000', :tool_botton=>'990000', :text=>'000000', :tool_body=>'FFFFFF', :background=>'660000', :body=>'FFFFFF'

    ColorTemplate.create :name=>'FFFFFF', :slogan=>'FFFFFF', :title=>'006699', :subtitle=>'FF6600', :checked_menu=>'FF6600', :unchecked_menu=>'336699', :background_menu=>'336699', :tool_botton=>'336699', :text=>'000000', :tool_body=>'FFFFFF', :background=>'336699', :body=>'FFFFFF'
  end

  def self.down
  end
end
