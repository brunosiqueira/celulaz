require "load_map"
class BusinessCardsController < ApplicationController
  layout "new_business_cards"
  helper "company/profile"
  skip_before_filter :login_required
  after_filter :register_visitor, :only=>:show
  include LoadMap
  
  def index
    redirect_to :controller => "search"
  end
  
  def show
    @company = Company.find(params[:id])
    @map = get_map(@company.address_business_card.to_s)
    @search = params[:search]
  end

  private
  def register_visitor
    session_id = request.session_options[:id]
    url = "/business_cards/#{params[:id]}"
    if @company && !Visit.exists?(:request_url=>url,:session=>session_id)
      Visit.create :user_id=>logged_in? ? current_user.id : nil, :session=>session_id,
        :ip_address=>request.remote_ip, :request_url=>url
    end
  end
end
