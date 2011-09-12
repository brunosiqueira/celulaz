class Recommendation < ActionMailer::Base
  
  def sendrecommendation(email, company)
    subject    "[#{I18n.t("company.site_title")}] #{company.layout.name} convidou você fazer fazer negócios"
    recipients "#{email}"
    from       EMAIL
    sent_on    Time.now
    content_type "text/html"
    body :company => company
  end
end