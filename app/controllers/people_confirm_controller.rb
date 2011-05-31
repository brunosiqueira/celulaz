class PeopleConfirmController < ApplicationController
  before_filter :check_comercial_user
 
  layout "new_admin"
  def index
    @people = current_user.get_pendent_confirm_users params[:page]
  end

  def index_companies
    @companies = current_user.get_pendent_confirm_companies params[:page]
  end

  def show
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.find(params[:id])
    flash[:notice] = "Não foi possível confirmar a validade da pessoa com o usuário corrente."
    if current_user.can_confirm? @person
      current_user.confirm @person
      if @person.save
        flash[:notice] = "Confirmação realizada com sucesso!"
        UserMailer.deliver_confirmed_user(@person.user) if @person.user
      end
    end
    render :action=>"show"
  end

  def edit
    @person = Person.find(params[:id])
    if @person.user && @person.user.is_company?
      @company = @person.user.company
    end
  end

  def update
    @person = Person.find(params[:person_id])
    if params[:company]
      @company = @person.user.company
    end
    Person.transaction do
      @person.update_attributes!(params[:person])
      @company.update_attributes!(params[:company]) if @company
    end
    flash[:notice] = 'Pessoa atualizada com sucesso!'
    redirect_to :action=>:index
  rescue Exception => e
   render :action=>:edit
  end

    # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    @person.destroy if @person.users.empty?

    respond_to do |format|
      format.html { redirect_to(:action=>"index") }
      format.xml  { head :ok }
    end
  end
end