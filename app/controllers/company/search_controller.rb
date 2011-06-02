class Company::SearchController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  layout "company"
  def index
    page = params[:page] || 1
    @order = params[:order] || "layout_name ASC"
    @search = params[:search]
    @companies = Company.search(@search,:per_page=>15,:page=>page,
      :include=>:layout,:order=>@order)
  end
end
