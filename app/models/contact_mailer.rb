class ContactMailer < ActionMailer::Base
  layout "mailer"

  def contact_us(contact)
    subject    "[#{I18n.t("company.site_title")}] #{contact.name}: Mensagem enviada pelo fale-conosco"
    recipients "#{SAC_EMAIL}"
    from       EMAIL
    sent_on    Time.now
    content_type "text/html"
    body       :name=>contact.name,:email_from=>contact.email,:ddd=>contact.ddd,
      :phone=>contact.phone,:city=>contact.city,:description=>contact.description
  end

end
