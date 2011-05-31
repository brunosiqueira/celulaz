class ZController < ApplicationController
  include LoadMap
  skip_before_filter :login_required
  before_filter :find_company,:except=>:register_visitor
  skip_before_filter :verify_authenticity_token,:only=>:register_visitor
  before_filter :set_cross_domain_access,:only=>:register_visitor
  def index
    @user = @company.user
    @layout = @company.layout
    @color = @layout.color
    @tab = @layout.tabs_with_components.find_by_id(params[:tab_id]) || @layout.tabs_with_components.first
    render :layout=>"z/template#{@layout.architecture_type}"
  end

  def show
    @map = get_location( @company.layout.address_site.to_s)
    render :layout=>false
  end

  def component
    @user = @company.user
    @layout = @company.layout
    @color = @layout.color
    @component = @layout.components.find params[:component_id]
    @tab = @component.tab
    render :layout=>"z/template#{@layout.architecture_type}", :template=>"z/#{@component[:type].underscore}.html"
  end

  def register_visitor
    if @company = CompanyZ.find(:first,:include=>[{:layout,:color},:user],:conditions=>["users.login=?",URI::unescape(params[:id])])
      session_id = session[:session_id]
      url = "/z/#{params[:id]}"
      if !Visit.exists?(:request_url=>url,:session=>session_id)
        Visit.create :user_id=>logged_in? ? current_user.id : nil, :session=>session_id,
          :ip_address=>request.remote_ip, :request_url=>url
      end
    end
    render :text=>true
  end

  private
  def find_company
    unless @company = Rails.cache.read("#{URI::unescape(params[:id])}_layout")
      @company = CompanyZ.find(:first,:include=>[{:layout,:color},:user],:conditions=>["users.login=?",URI::unescape(params[:id])])
      Rails.cache.write("#{URI::unescape(params[:id])}_layout", @company)
      redirect_to :controller=>"not_found" if @company.nil?
    end
  rescue
    redirect_to :controller=>"not_found"
  end


end