require 'test_helper'

class Financial::CompanyNotPayedControllerTest < ActionController::TestCase
  test "index" do
    login_as :admin
    get :index
    assert_response :success
    assert assigns(:companies)
  end

  test "should show company" do
    login_as :admin
    get :show, :id=>companies(:empresa_valid_2)
    assert_response :success
    assert assigns(:company)
  end
end
