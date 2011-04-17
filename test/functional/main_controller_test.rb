require 'test_helper'

class MainControllerTest < ActionController::TestCase

  test "main_not_logged" do
    get :index
    assert_response :success
  end
  
  test "main_logged" do
    login_as "admin"
    get :index
    assert_redirected_to :controller=>"users"
  end

  test "main_logged_as_company" do
    login_as "empresa_valid"
    get :index
    assert_redirected_to company_root_path
  end

  test "natal_not_logged" do
    get :natal
    assert_response :success
  end

  test "natal_logged" do
    login_as "admin"
    get :natal
    assert_redirected_to :controller=>"users"
  end
end
