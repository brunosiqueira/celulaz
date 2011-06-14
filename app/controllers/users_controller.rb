class UsersController < ApplicationController
  #Liberar quando o cadastro estiver aberto para público
  #skip_before_filter :login_required, :only => [:new, :create]
  before_filter :not_logged_or_not_company_logged_required, :only => [:new, :create]
  before_filter :not_company_logged, :only=>[:index]
  before_filter :can_enable_disable, :only=>[:enable,:disable]
  before_filter :load_company, :only=>[:edit,:update]
  before_filter :login_as_director_required,:only=>:update_attribute

  layout "new_admin"
  
  def index
    @user_type = params[:user_type]
    if @user_type && @user_type.eql?("user_company")
      @users =  current_user.get_subusers_companies(params[:page], params[:q])
    else
      @users =  current_user.get_subusers_non_companies(params[:page], params[:q])
    end
  end
  
  
  #This show action only allows users to view their own profile
  def show
    @user = current_user
  end

  # render new.rhtml
  def new
    @user = User.new
    @person = Person.new
    @company = Company.new
    @company.address_business_card = Address.new
    @user.company = @company
    @user_type = UserCompany.name
    @company_type = CompanyS.name
    @user_type=params[:type] || current_user.subusers.first
    render :template=>"users/new_#{@user_type == UserCompany.name ? "company" : "comercial"}"
  end
  
  def create
    cookies.delete :auth_token
    @user_type = params[:type]
    if @user_type == UserCompany.name
      create_company_user
    else
      create_comercial_user
    end
  rescue
    @person.valid?
    @user.valid?
    @company.valid? if @company
    flash[:error] = "Houve um problema criando sua conta."
    render :template=>"users/new_#{@user_type == UserCompany.name ? "company" : "comercial"}"
  end

  def new_page_2
    
  end

  def create_page_2
    @user = UserCompany.find params[:id]
    User.transaction do
      @user.person.update_attributes!(params[:person])
      @user.company.update_attributes!(params[:company])
    end
    @user_type = "user_company"
    redirect_to :action=>:index
  end
  
  def edit
    @user = current_company || current_user
  end
  
  def update
    @user = User.find(current_company || current_user)
    @person = @user.person
    if @user.update_attributes(params[:user])# && @person.update_attributes(params[:person])
      #Rails.cache.write('user_#{@user.id}', @user.id)
      flash[:notice] = "Usuário Atualizado"
      redirect_to root_path
    else      
      flash[:notice] = "Ocorreram Erros ao Alterar a Senha"
      render :action=>:edit
    end
  end
  
  def disable
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled, false)
      flash[:notice] = "Usuário desabilitado"
    else
      flash[:error] = "Houve um problema ao desabilitar o usuário."
    end
    redirect_to :action => 'index'
  end
  
  def enable
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled, true)
      flash[:notice] = "Usuário habilitado"
    else
      flash[:error] = "Houve um problema ao habilitar o usuário."
    end
    redirect_to :action => 'index'
  end
  
  def destroy
    @user = User.find params[:id]
    if !@user.active? || (current_user.is_director? || current_user.is_administrator?)
      UserMailer.delay.deliver_destroy(@user.login,current_user.login)
      User.destroy(@user.id)
    else
      flash[:notice] = "O usuário já foi ativado e não pode mais ser excluído."
    end
    redirect_to :action=>:index
  end

  def resend_signup_mail
    @user = User.find params[:id]
    if @user.active?
      flash[:error] = "O usuário #{@user.login} já está ativo e não pode receber um segundo e-mail de ativação"
    else
      UserMailer.deliver_signup_notification(@user)
      flash[:notice] = "O e-mail de ativação foi reenviado para o usuário #{@user.login} (a senha não será exibida no e-mail)"
    end
    redirect_to :action=>"index"
  end

  def resend_welcome_mail
    @user = User.find params[:id]
    UserMailer.deliver_welcome(@user)
    flash[:notice] = "O e-mail de boas vindas foi reenviado para o usuário #{@user.login}"
    redirect_to :action=>"index"
  end

  def update_attribute
    @user = User.find params[:id]
    @user.update_attributes(params[:field]=>params[:value])
    @user.reload
    render :text=>@user.email
  end
  
  protected
  def create_owner(user)
    if logged_in? and !login_as_director_required
      person = self.current_user.person
      person.person_users.create(:user=>user)
    end
  end

  private

  def can_enable_disable
    permission_denied if current_user.is_company?
  end

  def create_comercial_user
    @user = @user_type.constantize.new(params[:user])

    create_load_person

    #Atribui a filial do  usuário corrente, caso o mesmo não seja administrador ou diretor
    @person.subsidiary = current_user.person.subsidiary unless current_user.is_director? || current_user.is_administrator?

    current_user.confirm(@person)

    User.transaction do
      @user.save!
      @person.users << @user
      @person.save!
      @user.person = @person
      @user.save!
      User.find_and_activate! @user.activation_code
    end

    flash[:notice] = "Obrigado por se cadastrar! Por favor cheque seu email para ativar sua conta e se logar no sistema."
    @users = current_user.get_subusers_non_companies
    render :action=>"index"
  end

  def create_company_user
    @user = UserCompany.new(params[:user])

    create_load_person
    #Atribui a filial do  usuário corrente, caso o mesmo não seja administrador ou diretor
    @person.subsidiary = current_user.person.subsidiary unless current_user.is_director? || current_user.is_administrator?

    current_user.confirm(@person)

    @company_type = params[:company_type] || CompanyS.name
    @user.company =  @company_type.constantize.new(params[:company])
    @company = @user.company
    @company.address_business_card = Address.new params[:address]

    User.transaction do
      @user.save!
      @person.users << @user
      @person.save!
      @company.save!
      @user.person = @person
      @user.save!
      User.find_and_activate! @user.activation_code
      @person.reload
      @person.save!
    end

    flash[:notice] = "Obrigado por se cadastrar! Por favor cheque seu email para ativar sua conta e se logar no sistema."

    @sellers = [current_user.person] + current_user.people(true,[],nil,false)
    render :action=>"new_page_2"
  end


  def create_load_person
    if !params[:person][:cpf].blank? && @person = Person.find_by_cpf(params[:person][:cpf])
      if(current_user.need_subsidiary? && !current_user.person.subsidiary.eql?(@person.subsidiary))
        @person = Person.new
        raise
      end
    end
    @person ||= Person.new(params[:person])
  end

end
