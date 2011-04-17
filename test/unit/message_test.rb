require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  fixtures :messages
  
  test "shoud be a valid user message" do
    message = messages(:valid_user_message)
    assert message.valid?
  end
  
  test "shoud be a invalid user message" do
    message = messages(:invalid_user_message)
    assert_nil message.errors.on(:sender)
    assert_nil message.errors.on(:subject)
    assert_nil message.errors.on(:body)
    assert message.invalid?
  end
  
  test "shoud be a valid public message" do
    message = messages(:valid_public_message)
    assert message.valid?
  end
  
  test "shoud be a invalid public message" do
    message = messages(:invalid_public_message)
    assert_nil message.errors.on(:sender_email)
    assert_nil message.errors.on(:body)
    assert message.invalid?
  end
end
