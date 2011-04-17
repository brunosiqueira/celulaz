class VisitSchedulerMailer < ActionMailer::Base
  layout "mailer"
  
  def scheduler(name,email_from,ddd,phone,address,city,subsidiary_title, segment_name,time_to_visit,description)
    subject    "[#{I18n.t("company.site_title")}] #{name}: Solicitação de visita"
    recipients "#{SAC_EMAIL}"
    from       EMAIL
    sent_on    Time.now
    content_type "text/html"
    body       :name=>name,:email_from=>email_from,:ddd=>ddd,
      :phone=>phone,:address=>address,:city=>city,:subsidiary_title=>subsidiary_title,
      :segment_name=>segment_name,:time_to_visit=>time_to_visit,:description=>description
  end
end
