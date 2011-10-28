class SystemModules::ProfilesController < ApplicationController

  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :unread_messages, :only => [:show]
  after_filter :register_visitor, :only=>:show

  layout "new_layout"

  def index
  end

  def show
    @company = Company.find params[:id]
    @friends = @company.random_friends
    @testimonial = Testimonial.find_by_user_id(current_user.id, :limit => 1)
    respond_to do |format|
      format.html
    end
  end
  
  def activities
    @company = Company.find params[:id]
    page = params[:page] || 1
    @feed_items = @company.public_feed_items.paginate :per_page => 10, :page => page
    respond_to do |format|
      format.html
    end
  end
  
  def partners
    @company = Company.find params[:id]
    #@q = params[:q]
    @friends = @company.friends(
      page=( (params[:page]) ? params[:page] : 1),
      24, "(layouts.name LIKE '%#{@q}%')")
    
    respond_to do |format|
      format.html
    end
  end
  
  def testimonials
    @company = Company.find params[:id]
    #se o perfil for igual ao usuario logado
    if @company.user.id == current_company.id
      @pending_testimonials = Testimonial.all(:conditions => ['user_id = ? AND approved = ?', current_company.id, false])
      @approved_testimonials = Testimonial.all(:conditions => ['user_id = ? AND approved = ?', current_company.id, true])
    else
      @pending_testimonials = Testimonial.all(:conditions => ['user_id = ? AND approved = ?', @company.user.id, false])
      @approved_testimonials = Testimonial.all(:conditions => ['user_id = ? AND approved = ?', @company.user.id, true])
    end

    respond_to do |format|
      format.html
    end
  end
  
  private
  def register_visitor
    session_id = request.session_options[:id]
    url = "/system_modules/profiles/#{params[:id]}"
    if @company && !Visit.exists?(:request_url=>url,:session=>session_id)
      Visit.create :user_id=>logged_in? ? current_user.id : nil, :session=>session_id,
        :ip_address=>request.remote_ip, :request_url=>url
    end
  end
end