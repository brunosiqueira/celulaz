class BusinessesController < ApplicationController
  before_filter :check_comercial_user

  layout "new_admin"
  def index
    @businesses = Business.paginate(:page=>(params[:page]||1))

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @businesses }
    end
  end

  # GET /businesses/1
  # GET /businesses/1.xml
  def show
    @business = Business.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @business }
    end
  end

end
