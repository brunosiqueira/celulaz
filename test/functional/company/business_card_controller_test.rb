require 'test_helper'

class Company::BusinessCardControllerTest < ActionController::TestCase
  test "index" do
    login_as :empresa_valid_2
    get :index
    assert_response :success
    assert_not_nil assigns(:map)
  end

  test "update presentation text" do
    login_as :empresa_valid
    get :update, :id=>"presentation_text",:value => "123"
    assert_response :success
    layouts(:empresa_valid).reload
    assert_equal("123", layouts(:empresa_valid).presentation_text)
  end
end
