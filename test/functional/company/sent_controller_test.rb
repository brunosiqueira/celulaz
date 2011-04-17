require 'test_helper'

class Company::SentControllerTest < ActionController::TestCase
  fixtures :messages, :message_copies
  
  def setup
    login_as :empresa_valid
  end
  
  test "should get all sent messages" do 
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end
  
  test "should show sent message" do
    get(:show, {'id' => messages(:valid_user_message).id})
    assert assigns(:message)
    assert_response :success
  end
  
end
