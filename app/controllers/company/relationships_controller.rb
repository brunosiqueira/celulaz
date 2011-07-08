class Company::RelationshipsController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  layout "company"
  
  def index
    @q = params[:q]
    @friends = @company.friends(
      page=( (params[:page]) ? params[:page] : 1),
      16, "(layouts.name LIKE '%#{@q}%')")
  end
  
  def friend_requests
    if request.post? && params[:company_origin_id] && params[:status]
      @company.validate_friend_requests(status=params[:status], company_origin_id=params[:company_origin_id])
    end
    respond_to do |format|
      format.js {render :text=>true }
      format.html {render :text=>true }
    end
  end
end
