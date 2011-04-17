require 'test_helper'

class Company::TabsControllerTest < ActionController::TestCase
  test "create" do
    login_as :empresa_valid
    assert_difference "Tab.count", 1 do
      post :create, :tab=>{:title=>"Aba 1"}
    end
    assert_response :success
  end

  test "reorder" do
    login_as :empresa_valid
    post :reorder, :tab_ids=>[tabs(:two),tabs(:one)]
    tabs(:one).reload
    tabs(:two).reload
    assert_equal 1, tabs(:two).order
    assert_equal 2, tabs(:one).order
    assert_response :success
  end

  test "destroy" do 
    login_as :empresa_valid
    assert_difference "Tab.count", -1 do
      post :destroy, :id=>tabs(:one)
    end
    assert_response :success
  end
end
