class CompanySellerController < ApplicationController
  layout "new_admin"
  
  def new
    @company = Company.find(params[:id])
    @sellers = [current_user.person] + current_user.people(true,[],nil,false)
  rescue Exception => e
    flash[:notice] = I18n.t "company.messages.not_found"
    redirect_to :controller=>:company_management,:action=>"index"
  end

  def create
    @company = Company.find(params[:id])
    seller = Person.find_by_id params[:company][:person_id]
    @company.seller = seller
    company_user = @company.user
    company_person = company_user.person
    company_person.web_adm = seller.web_adm
    User.transaction do
      company_person.save!
      @company.update_attributes!(params[:company])
    end
    flash[:notice] = I18n.t "company.messages.success_associated_seller"
    redirect_to :controller=>"company_management",:action=>"index"
  rescue
    flash[:notice] = I18n.t "company.messages.error_updating"
    redirect_to :controller=>"company_management",:action=>"index"
  end

  def destroy
    company = Company.find(params[:id])
    company.seller = nil
    company.save
    redirect_to :controller=>:company_management, :action=>:index
  end

end
