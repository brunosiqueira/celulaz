require 'test_helper'

class Company::AddressControllerTest < ActionController::TestCase
  test "update address" do
    login_as :empresa_valid
    get :update,:address=>{}
    assert_response :success
    assert_not_nil assigns(:address)
  end
  
  test "update address failed" do
    login_as :empresa_valid
    get :update,:address=>{:street=>nil}
    assert_response :success
    assert_nil assigns(:address)
  end
end
