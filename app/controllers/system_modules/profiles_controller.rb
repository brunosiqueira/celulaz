class SystemModules::ProfilesController < ApplicationController

  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :unread_messages, :only => [:show]
  layout "company", :except => [ :activities, :partners ]

  def index
  end

  def show
    @company = Company.find params[:id]
    @friends = @company.friends
    respond_to do |format|
      format.html
    end
  end
  
  def activities
    @company = Company.find params[:id]
    page = params[:page] || 1
    @feed_items = @company.public_feed_items.paginate :per_page => 10, :page => page
    respond_to do |format|
      format.js
    end
  end
  
  def partners
    @company = Company.find params[:id]
    @q = params[:q]
    @friends = @company.friends(
      page=( (params[:page]) ? params[:page] : 1),
      16, "(layouts.name LIKE '%#{@q}%')")
    @friend_requests = @company.friend_requests
    @suggestions = @company.friends_suggestions
  end
end
