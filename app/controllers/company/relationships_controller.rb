class Company::RelationshipsController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :unread_messages, :only => [:index]
  
  layout "new_layout"
  
  def index
    @q = params[:q]
    @friends = @company.friends(
      page=( (params[:page]) ? params[:page] : 1),
      18, "(layouts.name LIKE '%#{@q}%')")
      
    @friend_requests = @company.friend_requests
    @suggestions = @company.friends_suggestions
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
