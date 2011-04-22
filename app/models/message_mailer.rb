class MessageMailer < ActionMailer::Base
  
  layout "mailer",:except=>:to_friend
  helper :application
  def received(message)
    message = MessageCopy.find(:first, :include=>:recipient, :conditions=>{:id=>message.id})
    subject    "[#{I18n.t("company.site_title")}] Você recebeu uma nova mensagem"
    recipients "#{message.recipient.email}"
    from       EMAIL
    sent_on    Time.now
    content_type "text/html"
  end

  def to_friend(message_to_friend)
    subject    "[#{I18n.t("company.site_title")}] #{message_to_friend.name_from} enviou um e-mail"
    recipients "#{message_to_friend.email_to}"
    from       EMAIL
    sent_on    Time.now
    content_type "text/html"
    body :company=>message_to_friend.company, :user=>message_to_friend.company.user, :observations=>message_to_friend.observations,
      :layout=>message_to_friend.company.layout, :address=>message_to_friend.company.address_business_card
  end
end
