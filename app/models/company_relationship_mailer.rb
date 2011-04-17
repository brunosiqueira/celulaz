class CompanyRelationshipMailer < ActionMailer::Base
   layout "mailer", :except=> [:send_to_friend,:new_send_to_friend]
  helper :application
  def request(company_relationship,observations)
    company_relationship = CompanyRelationship.find(:first,:include=>[:origin,:destiny],:conditions=>{:id=>company_relationship.id})
    subject    "[#{I18n.t("company.site_title")}] Solicitação de Relacionamento"
    recipients "#{company_relationship.destiny.user.email}"
    from       EMAIL
    sent_on    Time.now
    content_type "text/html"
    body       :company_relationship=>company_relationship, :observations=>observations
  end
end
