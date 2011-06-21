class CompanyManagementController < ApplicationController
  before_filter :check_comercial_user

  layout "new_admin"
  #Exibe as empresas vizíveis para o usuário corrente
  def index
    @segment_id = params[:segment_id]
    page = params[:page] || 1
    @companies = current_user.paginate_companies(page,(@segment_id.eql?("Todos") ? nil : @segment_id))
  end

  def show
    id = params[:id]
    unless @user = UserCompany.find(:first,:conditions=>{:id=>id})
      flash[:notice] = I18n.t "company.messages.not_found"
      redirect_to :action=>"index"
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:notice] = 'Empresa atualizada com sucesso!'
        format.html { redirect_to(:action=>:show,:id=>@company) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def loggin_as_company
    user = UserCompany.find_by_id(params[:id])
    if user && current_user.owns_company?(user.company)
      session[:current_company_id] = user.id
      redirect_to system_root_path
    else
      flash[:notice] = I18n.t "company.messages.not_manageable"
      redirect_to :action=>:index
    end
  end

  def loggout_as_company
    session[:current_company_id] = nil
    redirect_to root_path
  end

  def change_type_to_s
    @company = Company.find params[:id]
    @user = @company.user
    @company.to_company_s
    flash[:notice] = "Tipo de conta alterado com sucesso."
    render :action=>"show"
  end

  def change_type_to_z
    @company = Company.find params[:id]
    @company.attributes = params[:company]
    @person = @company.person
    @person.attributes = params[:person]
    @user = @company.user
    Company.transaction do
      @company.to_company_z 
      @person.save!
      flash[:notice] = "Tipo de conta alterado com sucesso."
      render :action=>"show"
    end
  rescue
    render :action=>"change_to_z"
  end

  def change_to_z
    @company = CompanyS.find params[:id]
    @person = @company.person
  end

end
