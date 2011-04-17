class ResendActivationMailController < ApplicationController
  skip_before_filter :login_required
  layout "e-mail"
  
  def new

  end

  def create
     if @user = User.find(:first, :conditions=>["email=? and activated_at is null",params[:email]])
       UserMailer.deliver_signup_notification(@user)
       flash[:notice] = "E-mail de ativação enviado para #{@user.email}"
     else
       flash[:notice] = "Não foi encontrado o usuário com o email em questão. Talvez o usuário já tenha sido ativado."
     end
     redirect_to login_path
  end

end
