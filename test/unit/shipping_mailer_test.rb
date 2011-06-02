require 'test_helper'

class ShippingMailerTest < ActionMailer::TestCase
  test "send_shipping_file" do
    emails = ["email1@test.com","email2@test.com"]
    file = File.new "#{shippings(:with_titles).code}.txt","w+"
    @expected.subject = "[#{I18n.t("company.site_title")}]: Geração de Cobrança"
    @expected.date    = Time.now
    @expected.to = emails
    @expected.content_type = "text/html"

    response = ShippingMailer.create_send_shipping_file(emails,shippings(:with_titles),file)
    #assert_match(/Quantidade de Títulos: #{shippings(:with_titles).titles.size}/, response.body)
    assert_equal @expected.subject,response.subject
    #assert_equal  @expected.content_type,response.content_type
    assert_equal emails,response.to
    assert_equal [EMAIL],response.from
    assert_match /http:\/\/#{SITE_URL}\/financial\/shippings\//,response.body
  end

end
