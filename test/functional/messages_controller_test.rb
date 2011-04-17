require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  
  test "should create a message to a company from anonymous user" do
    assert_difference('Message.count') do
      post :create, :message => 
                    { 
                      :to => "8",
                      :subject => "Teste - Mensagem enviada do business card",
                      :body => "Corpo da mensagem", 
                      :sender_email => "tester@gmail.com"
                    }
    end
    assert assigns(:message)
    assert_response :success
  end
end