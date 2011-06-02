class UserMailer < ActionMailer::Base
  layout "mailer"
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Por favor, ative sua conta.'
    @body[:url_forgot_password]  = "http://#{SITE_URL}/esqueci-a-senha"
    @body[:url]  = "http://#{SITE_URL}/activate/#{user.activation_code}"
  end

  def confirmed_user(user)
    setup_email(user)
    @subject    += 'Sua conta foi confirmada.'
    @body[:user] = user
    @body[:url]  = "http://#{SITE_URL}"
  end

  def notify_director(user_director, user)
    setup_email(user_director)
    @body[:user] = user
    @body[:person] = user.person 
    @subject    += 'Usuário Criado'
  end
  
  def forgot_password(user)
    setup_email(user)
    @subject    += 'Você solicitou a alteração da sua senha'
    @body[:url]  = "http://#{SITE_URL}/reiniciar-senha/#{user.password_reset_code}"

  end
  
  def reset_password(user)
    setup_email(user)
    @subject    += 'Sua senha foi reiniciada.'
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Sua conta foi ativada!'
    @body[:url]  = "http://#{SITE_URL}/"
  end

  def welcome(user)
    setup_email(user)
    @subject    += "Bem vindo ao #{I18n.t("company.site_title")}!"
    @body[:user]  = user
    @body[:url]  = "http://#{SITE_URL}/reiniciar-senha/#{user.password_reset_code}"
  end

  def destroy(deleted_login,current_login)
    @recipients  = "#{SAC_EMAIL}"
    @from        = EMAIL
    @subject     = 
    @sent_on     = Time.now
    @content_type = "text/html" 
    @subject    = "[#{I18n.t("company.site_title")}]Exclusão de usuário"
    @body[:deleted_login]  = deleted_login
    @body[:current_login]  = current_login
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
