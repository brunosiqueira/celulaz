require 'test_helper'

class Company::LayoutControllerTest < ActionController::TestCase
  test "update background_top" do
    login_as :empresa_valid_2
    get :update_background_top,:id=>"/image/temp_small"
    assert_response :success
    assigns(:layout).reload
    assert_equal "/image/temp", assigns(:layout).background_top
  end
  test "update background" do
    login_as :empresa_valid_2
    get :update_background,:id=>"/image/temp_small"
    assert_response :success
    assigns(:layout).reload
    assert_equal "/image/temp", assigns(:layout).background_file_name
  end
end
