require 'test_helper'

class Company::TabComponentsControllerTest < ActionController::TestCase
  test "create" do
    login_as :empresa_valid
    assert_difference "TabComponent.count", 1 do
      put :create,:id=>components(:gallery),:tab_component=>{:full_line=>true,:column=>1,:tab_id=>tabs(:one),:line=>5}
    end
  end
  test "replace" do
    login_as :empresa_valid
    assert_difference "TabComponent.count", 0 do
      put :create,:id=>components(:four),:tab_component=>{:full_line=>true,:column=>1,:tab_id=>tabs(:one),:line=>5}
    end
  end
  test "update" do
    login_as :empresa_valid
    assert !components(:four).tab_component.full_line
    assert_difference "TabComponent.count", 0 do
      put :update,:id=>components(:four),:full_line=>true
    end
    components(:four).reload
    assert components(:four).tab_component.full_line
  end
  test "destroy" do
    login_as :empresa_valid
    assert_difference "TabComponent.count", -1 do
      put :destroy,:id=>components(:four)
    end
  end
end
