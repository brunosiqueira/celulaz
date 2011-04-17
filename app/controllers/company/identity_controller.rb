class Company::IdentityController < ApplicationController
  before_filter :login_with_company_required
  before_filter :login_with_company_z_required
  before_filter :load_company
  before_filter :check_if_new, :except=>[:create,:update]
  after_filter :clean_cache
  layout "company"

  def new
  end

  def create
    @layout.update_attribute(:architecture_type,params[:layout])
    render :action=>"edit"
  end

  def edit
  end

  def update
    respond_to do |format|
      format.js
      format.html
    end
  end

  private
  def check_if_new
    if @layout.architecture_type.nil?
      redirect_to :action=>"new" unless params[:action].eql? "new"
    else
      redirect_to :action=>"edit" unless params[:action].eql? "edit"
    end
  end
end
