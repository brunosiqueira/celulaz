require 'test_helper'

class DomainsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "update success" do
    login_as :admin
    user = users(:empresa_valid)
    get :update, :id=>users(:empresa_valid).id, :value=>"empresa.com.br"
    assert_response :success
    users(:empresa_valid).reload
    assert_equal "empresa.com.br", users(:empresa_valid).domain
  end
end
