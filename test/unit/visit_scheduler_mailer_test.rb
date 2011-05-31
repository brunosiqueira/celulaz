require 'test_helper'

class VisitSchedulerMailerTest < ActionMailer::TestCase
  test "scheduler" do
    emails=["email1@yahoo.com","email2@yahoo.com"]
    name="Paulo"
    email_from="emailfrom@yahoo.com.br"
    ddd="21"
    phone="88888888"
    address="Rua louca"
    city="Niteroi"
    subsidiary_title="Rio de Janeiro"
     segment_name="Alimentação"
    time_to_visit="Indiferente"
    description="blablabla"
    
    @expected.subject = "[#{I18n.t("company.site_title")}] #{name}: Solicitação de visita"
    @expected.body    = read_fixture('scheduler')
    @expected.date    = Time.now
    @expected.set_content_type 'text/html'
    @expected.to 
    @expected.charset = "utf-8"
    @expected.from_addrs EMAIL
    response = VisitSchedulerMailer.create_scheduler(name,email_from,ddd,phone,address,city,subsidiary_title, segment_name,time_to_visit,description)
    assert_equal @expected.subject,response.subject
    assert_equal  @expected.content_type,response.content_type
    assert_equal [SAC_EMAIL],response.to
    assert_equal @expected.charset,response.charset
    assert_equal [EMAIL],response.from
  end

end
