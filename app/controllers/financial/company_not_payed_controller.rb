class Financial::CompanyNotPayedController < ApplicationController
  before_filter :login_as_financial_user_required
  layout "new_admin"
  def index
    @page = params[:page] || 1
    @companies = CompanyZ.paginate_not_payed(@page)
  end

  def show
    @page = params[:page] || 1
    @company = CompanyZ.find :first, :include=>"contracts", :conditions=>{:id=>params[:id]}
  end
end
