class CompanyMailer < ActionMailer::Base
  
  layout "mailer", :except=> [:send_to_friend,:new_send_to_friend]
  helper :application
  def send_to_friend(name_from,email_from,email_to,company)
    subject    "[#{I18n.t("company.site_title")}] #{name_from} #{I18n.t("company.sent")}"
    recipients "#{email_to}"
    from       EMAIL
    sent_on    Time.now
    content_type "text/html"
    body       :company=>company,:name_from=>name_from,
      :email_from=>email_from,:layout=>company.layout,:address=>company.address_business_card
  end
  
  def new_send_to_friend(email_to, company)
    subject    "[#{I18n.t("company.site_title")}] Dica de site"
    recipients "#{email_to}"
    from       EMAIL
    sent_on    Time.now
    content_type "text/html"
    body       :company => company,:layout=>company.layout,:address=>company.address_business_card
  end

  def changed_to_z(company)
    create_email(company,"[#{I18n.t("company.site_title")}] Você adquiriu uma conta Z!")
  end

  def changed_to_s(company)
    create_email(company,"[#{I18n.t("company.site_title")}] Sua conta Z foi suspensa.")
  end

  private
  def create_email(company,subject)
    subject    subject
    recipients "#{company.user.email}"
    from       EMAIL
    sent_on    Time.now
    content_type "text/html"
    body       :user=>company.user
  end

end
