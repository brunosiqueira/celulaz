class AccountsController < ApplicationController
  before_filter :not_logged_in_required, :only => :show
  skip_before_filter :login_required, :only => :show
  before_filter :load_company, :only=>[:edit,:update]

  layout "new_admin"
  # Activate action
  def show
    # Uncomment and change paths to have user logged in after activation - not recommended
    #self.current_user = User.find_and_activate!(params[:id])
    User.find_and_activate!(params[:id])
    flash[:notice] = "Seu email foi validado. Após a confirmação da sua conta, você pode se logar"
    redirect_to login_path
  rescue User::ArgumentError
    flash[:notice] = 'Código de ativação não encontrado. Favor, tentar criar outra conta'
    redirect_to signup_path 
  rescue User::ActivationCodeNotFound
    flash[:notice] = 'Código de ativação não encontrado. Favor, tentar criar outra conta'
    redirect_to signup_path
  rescue User::AlreadyActivated
    flash[:notice] = "Seu email já foi validado. Após a confirmação da sua conta, você pode se logar"
    redirect_to login_path
  end
  
  def edit
  end
  
  # Change password action  
  def update
    return unless request.post?
    user = current_company || current_user
    if User.authenticate(user.login, params[:old_password])
      if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
        user.password_confirmation = params[:password_confirmation]
        user.password = params[:password]
        if user.save
          flash[:notice] = "Senha Alterada com Sucesso."
          respond_to do |format|
            format.html{redirect_to root_path }#profile_url(user.login)
            format.js
          end
        else
          flash[:error] = "Ocorreu um erro. A senha não pôde ser alterada."

          respond_to do |format|
            format.html{render :action=>"edit"}#profile_url(user.login)
            format.js
          end
        end
      else
        flash[:error] = "Nova senha não é igual a confirmação."
        @old_password = params[:old_password]
        respond_to do |format|
          format.html{render :action=>"edit"}#profile_url(user.login)
          format.js
        end
      end
    else
      flash[:error] = "Senha corrente inválida."
      respond_to do |format|
        format.html{render :action=>"edit"}#profile_url(user.login)
        format.js
      end
    end 
  end

end
