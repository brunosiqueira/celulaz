require 'test_helper'

class Company::MessagesControllerTest < ActionController::TestCase
  fixtures :messages, :message_copies
  
  def setup
    login_as :empresa_valid
  end
  
  test "should create a message" do
    assert_difference('Message.count') do
      post :create, :message => 
                    { 
                      :sender => "8",
                      :to => "8",
                      :subject => "Teste - Mensagem enviada do sistema",
                      :body => "Corpo da mensagem"
                    }
    end
    assert assigns(:message)
    assert_response :success
  end
  
  test "should reply a message" do 
    assert_difference('Message.count') do
      post :create, :message => 
                    { 
                      :sender => "8",
                      :to => "8",
                      :subject => "Teste - Mensagem enviada do sistema",
                      :body => "Corpo da mensagem de resposta"
                    }
    end
    assert assigns(:message)
    assert_response :success
  end
  
  test "should show a message" do
    get(:show, {'id' => messages(:valid_user_message).id})
    assert assigns(:message)
    assert_response :success
  end
  
  test "should change message status to delete" do
    delete :destroy, :id => message_copies(:valid_user_message).message_id.to_s
    assert_response :success
  end
  
end
