require 'test_helper'

class Company::ConstructionControllerTest < ActionController::TestCase
  test "show content" do
    login_as :empresa_valid_2
    get :content
    assert_response :success
  end

end
