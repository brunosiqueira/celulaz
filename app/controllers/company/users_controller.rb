class Company::UsersController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company,:except=>:public
  before_filter :unread_messages, :only => [:edit]
  layout "company"
  def edit
    @user = current_company
  end

  def update
    @user = current_company
    if @user.update_attributes(params[:user])
      flash[:notice] = "Usuário Atualizado"
    end
    render :action=>:edit
  end

  def update_profile_logo
    @user = current_company
    @user.company.update_attributes(params[:company])
    render :action=>"edit"
  end
end
