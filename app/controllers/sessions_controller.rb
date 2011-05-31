# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  
  before_filter :not_logged_in_required, :only => [:new, :create]
  skip_before_filter :login_required, :only => [:new, :create,:is_logged]
  
  # render new.rhtml
  def new
  end
  
  def create
    login = params[:login] || params[0]
    password = params[:password] || params[1]
    password_authentication(login, password)
  end
  
  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Você saiu da sua conta."
    redirect_to login_path    
  end

  protected
  
  # Updated 2/20/08
  def password_authentication(login, password)
    user = User.authenticate(login, password)
    if user.nil?
      failed_login("Seu usuário ou senha estão incorretos.")
    elsif user.activated_at.blank?  
      failed_login("Sua conta não está ativa. Favor verificar o e-mail para ativar a conta.")
    elsif user.enabled == false
      failed_login("Sua conta foi desabilitada.")
    elsif !user.confirmed?
      failed_login("Seus dados pessoais ainda não foram confirmados pela administração.")
    else
      self.current_user = user
      successful_login
    end
  end
  
  private
  
  def failed_login(message)
    flash[:error] = message
    redirect_to :controller=>'main'
  end
  
  def successful_login
    if params[:remember_me] == "1"
      self.current_user.remember_me
      cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
    end
    
    flash[:notice] = "Logado com sucesso"
    return_to = session[:return_to]
    if return_to.nil?
      redirect_to_user_role
     else
      redirect_to return_to
    end
  end

end
