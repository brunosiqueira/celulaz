class TitleMailer < ActionMailer::Base
  layout "mailer"

  def accepted(title)
    setup_email(title.company.user)
    @subject    += 'Seu boleto já está disponível no nosso site.'
    @body[:url]  = "http://#{SITE_URL}/financial/titles_not_payed"
    @body[:url_boleto]  = "http://#{SITE_URL}/financial/titles_not_payed/show/#{title.id}"
  end

  protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = EMAIL
    @subject     = "[#{I18n.t("company.site_title")}] "
    @sent_on     = Time.now
    @body[:user] = user
    @content_type = "text/html"
  end
end
