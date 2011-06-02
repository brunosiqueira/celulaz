class Company::ProfileController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company,:except=>:public
  after_filter :register_visitor, :only=>:public
  layout "company"
  def index
    ids = @company.origin_ids + @company.destiny_ids + [@company.id]
    @feed_items = FeedItem.paginate :page=>params[:page],:joins=>:feeds,:per_page=>10,
      :include=>:item, :select=>"distinct feed_items.*",
      :conditions=>["feeds.company_id in (?) and (is_public = ? or company_id = ?)",ids,true,@company.id], :order=>"feed_items.updated_at desc"
    @message_to_friend = MessageToFriend.new
    respond_to do |format|
      #ajax response
      format.html
      format.js { render :partial => 'feeds',:object=>@feed_items}
    end
  end

  def public
    @company = Company.find params[:id]
    @feed_items = @company.public_feed_items.paginate :page=>params[:page] || 1
    respond_to do |format|
      format.html
    end
  end

  def destroy
    if @company.feed_items.exists?(:id=>params[:id])
      FeedItem.destroy params[:id]
    end
    render :text=>"true"
  end

  private
  def register_visitor
    session_id = request.session_options[:id]
    url = "/company/profile/public/#{params[:id]}"
    if @company && !Visit.exists?(:request_url=>url,:session=>session_id)
      Visit.create :user_id=>logged_in? ? current_user.id : nil, :session=>session_id,
        :ip_address=>request.remote_ip, :request_url=>url
    end
  end
end
