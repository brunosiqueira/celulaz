class Financial::CompanyNoActiveContractsController < ApplicationController
  before_filter :login_as_financial_user_required
  layout "new_admin"
  def index
    @page = params[:page]
    @companies = CompanyZ.paginate_no_contracts(@page)
  end

  def show
    @page = params[:page]
    @company = CompanyZ.find params[:id]
  end
end
