class Company::PeopleController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :unread_messages, :only => [:edit]
  layout "company"
    # GET /people/1/edit
  def edit
    @person = current_company.person
  end
  
    # PUT /people/1
  # PUT /people/1.xml
  def update
    @person = current_company.person

    respond_to do |format|
      if @person.update_attributes(params[:person])
        flash[:notice] = 'Dados atualizados com sucesso!'
        format.html { render :action => "edit" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end
end
