require 'test_helper'

class Company::ProfileControllerTest < ActionController::TestCase
  test "public profile" do
    login_as :empresa_valid_2
    get :public,:id=>companies(:empresa_valid_2)
    assert_response :success
    assert assigns(:company)
  end

  test "profile" do
    login_as :empresa_valid_2
    get :index
    assert_response :success
  end
end
