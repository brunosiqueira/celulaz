require 'test_helper'

class Financial::CompanyNoActiveContractsControllerTest < ActionController::TestCase
  test "index" do
    login_as "admin"
    get :index
    assert_response :success
    assert assigns(:companies)
  end

  test "show" do
    login_as "admin"
    get :index, :id=>companies()
    assert_response :success
    assert assigns(:companies)
  end
end
