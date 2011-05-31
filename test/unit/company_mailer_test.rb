require 'test_helper'

class CompanyMailerTest < ActionMailer::TestCase
  tests CompanyMailer
  def test_send_to_friend
    email_from = "emailfrom@test.com"
    name_from = "Name From"
    email_to = "emailto@test.com"
    
    response = CompanyMailer.create_send_to_friend(name_from,email_from,email_to,companies(:empresa_valid))
    assert_equal response.subject, "[#{I18n.t("company.site_title")}] #{name_from} #{I18n.t("company.sent")}"
    assert_equal response.to[0], "#{email_to}"
    assert_equal response.from[0], EMAIL
    assert_match(/#{companies(:empresa_valid).layout.name}/, response.body)
  end
  
  def test_changed_to_s
    response = CompanyMailer.create_changed_to_s(companies(:empresa_valid))
    assert_equal response.subject, "[#{I18n.t("company.site_title")}] Sua conta Z foi suspensa."
    assert_equal response.to[0], "#{companies(:empresa_valid).user.email}"
    assert_equal response.from[0], EMAIL
  end

  def test_changed_to_z
    response = CompanyMailer.create_changed_to_z(companies(:empresa_valid))
    assert_equal response.subject, "[#{I18n.t("company.site_title")}] Você adquiriu uma conta Z!"
    assert_equal response.to[0], "#{companies(:empresa_valid).user.email}"
    assert_equal response.from[0], EMAIL
  end
end
