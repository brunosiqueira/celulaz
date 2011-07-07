class Company::FeedLikesController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company,:except=>:public
  after_filter :register_visitor, :only=>:public
  layout nil

  def index
    @feed = FeedItem.find_by_id(params[:id])
    @companies = @feed.companies_likes
  end
  
  def create
    if @feed = FeedItem.find_by_id(params[:id])
      @feed.feed_likes.create(:company=>@company)
      @feed.reload
      render :json=> @feed.as_json
    else
      render :json=> "{}"
    end
  end

  def destroy
    debugger
    if @feed_item = FeedItem.find_by_id(params[:id])
      @like = @feed_item.feed_likes.find_by_company_id(@company.id)
      @feed_item.feed_likes.delete @like
      @feed_item.reload
      @feed_item.save
      render :json=> @feed_item.as_json
    else
      render :json=> "{}"
    end
  end
end
