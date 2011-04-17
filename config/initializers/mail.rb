require "smtp_tls"
# Email settings
ActionMailer::Base.delivery_method = :sendmail


#ActionMailer::Base.smtp_settings = {:address => "smtp.gmail.com",
#:port => 587,
#:authentication => :plain,
#:user_name => "suaempreza@suaempreza.com",
#:password => 'suaempreza'}


#ActionMailer::Base.smtp_settings = {
#  :address => "mail.teste.suaempreza.com.br",
#  :port => 25,
#  :domain => "teste.suaempreza.com.br",
#  :authentication => :login,
#  :user_name => "bsiqueira",
#  :password => "nonchalant"
#}
#ActionMailer::Base.smtp_settings = {
#  :address => "mail.suaempreza.com.br",
#  :port => 25,
#  :domain => "www.suaempreza.com.br",
#  :authentication => :login,
#  :user_name => "suaempreza",
#  :password => "embauguarda"
#}

ActionMailer::Base.smtp_settings = {
  :address => "mail.autonomoz.com.br",
  :port => 25,
  :domain => "www.autonomoz.com.br",
  :authentication => :login,
  :user_name => "autonomoz",
  :password => "embauguarda"
}

