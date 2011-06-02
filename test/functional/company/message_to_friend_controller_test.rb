require 'test_helper'

class Company::MessageToFriendControllerTest < ActionController::TestCase
  test "the send message" do
    login_as :empresa_valid
    get :create, :message_to_friend => { :email_to => "teste@hotmail.com" }
    assert_response :success
  end
end
