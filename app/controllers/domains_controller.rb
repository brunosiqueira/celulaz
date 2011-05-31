class DomainsController < ApplicationController
  before_filter :check_comercial_user
  layout "new_admin"
  def index
    @companies = current_user.paginate_companies params[:page]
  end

  def update
    if user = UserCompany.find(params[:id])
      user.update_attributes(:domain=> params[:value])
    end
    render :text=>params[:value]
  end
end
