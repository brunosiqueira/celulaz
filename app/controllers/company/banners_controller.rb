class Company::BannersController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  after_filter :clean_cache
  before_filter :check_template
  before_filter :unread_messages, :only => [:index]
  
  layout "new_layout"
  
  def index
    @banner = Banner.new
  end

  def create
    @banner = @layout.banners.create(params[:banner])
    @layout.banners.reload unless @banner.valid?
    redirect_to :action=>"index"
  end

  def destroy
    @banner = @layout.banners.find(params[:id])
    @layout.banners.delete(@banner)
    redirect_to :action=>"index"
  end
  private
  def check_template
    redirect_to :controller=>"company/identity",:action=>"new" if @layout.architecture_type.nil?
  end
end