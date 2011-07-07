class SystemModules::ProfilesController < ApplicationController

  before_filter :login_with_company_required
  before_filter :load_company

  layout "company", :except => :activities

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
    @feed_items = @company.public_feed_items.paginate :page=>params[:page] || 1
  end

end
