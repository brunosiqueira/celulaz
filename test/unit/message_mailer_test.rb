require 'test_helper'

class MessageMailerTest < ActionMailer::TestCase
  test "received" do
    response = MessageMailer.create_received(message_copies(:valid_user_message))
    assert_equal response.subject, "[#{I18n.t("company.site_title")}] Você recebeu uma nova mensagem"
    assert_equal response.from[0], EMAIL
  end

  test "to friend" do
    response = MessageMailer.create_to_friend(MessageToFriend.new(:email_to=>"teste@mail.com",:name_from=>"Jack",:company=>companies(:empresa_valid)))
    assert_equal response.subject, "[#{I18n.t("company.site_title")}] Jack enviou um e-mail"
    assert_equal response.to[0], "teste@mail.com"
    assert_equal response.from[0], EMAIL
  end

end
