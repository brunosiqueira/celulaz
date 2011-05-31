class ShippingMailer < ActionMailer::Base
  layout "mailer"

  def send_shipping_file(emails,shipping,file )
    file.rewind
    subject    "[#{I18n.t("company.site_title")}]: Geração de Cobrança"
    recipients emails
    from       EMAIL
    sent_on    Time.now
    body       :shipping=>shipping,:url=>"http://#{SITE_URL}/financial/shippings/#{shipping.id.to_s}"
    content_type "text/html"
  end
end
