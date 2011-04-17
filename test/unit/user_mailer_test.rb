require File.dirname(__FILE__) + '/../test_helper'
require 'user_mailer'

class UserMailerTest < ActionMailer::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"

  include ActionMailer::Quoting

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type "text", "html", { "charset" => CHARSET }
    @user = User.new( :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' )
  end

  def test_confirm
    response = UserMailer.create_signup_notification(@user)
    assert_equal("[#{I18n.t("company.site_title")}] Por favor, ative sua conta." , response.subject)
    assert_equal("quire@example.com" , response.to[0])
    assert_match(/activate/, response.body)
  end

  def test_activation
    response = UserMailer.create_activation(@user)
    assert_equal("[#{I18n.t("company.site_title")}] Sua conta foi ativada!" , response.subject)
    assert_equal("quire@example.com" , response.to[0])    
  end

  def test_notify_director
    response = UserMailer.create_notify_director(users(:director),@user)
    assert_equal("[#{I18n.t("company.site_title")}] Usuário Criado" , response.subject)
    assert_equal(users(:director).email, response.to[0])
  end

  def test_confirmed_user
    response = UserMailer.create_confirmed_user(@user)
    assert_equal("[#{I18n.t("company.site_title")}] Sua conta foi confirmada." , response.subject)
    assert_equal("quire@example.com", response.to[0])
    assert_match(/foram confirmadas./, response.body)
  end

  def test_welcome
    response = UserMailer.create_welcome(@user)
    assert_equal("[#{I18n.t("company.site_title")}] Bem vindo ao #{I18n.t("company.site_title")}!" , response.subject)
    assert_equal("quire@example.com", response.to[0])
    assert_match(/Bem vindo./, response.body)
  end
  def test_destroy
    response = UserMailer.create_destroy("deleted","current")
    assert_equal("[#{I18n.t("company.site_title")}]Exclusão de usuário" , response.subject)
    assert_equal(SAC_EMAIL, response.to[0])
    assert_match(/O usuário/, response.body)
  end

  private
  def read_fixture(action)
    IO.readlines("#{FIXTURES_PATH}/user_mailer/#{action}")
  end

  def encode(subject)
    quoted_printable(subject, CHARSET)
  end
end
