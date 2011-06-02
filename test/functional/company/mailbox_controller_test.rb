require 'test_helper'

class Company::MailboxControllerTest < ActionController::TestCase
  def setup
    login_as :empresa_valid
  end
  
  test "should get all received messages" do 
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end
end
