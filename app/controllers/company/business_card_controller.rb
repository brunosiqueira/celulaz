class Company::BusinessCardController < ApplicationController
  include LoadMap
  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :unread_messages, :only => [:index]
  layout "company"
  
  def index
    @map = get_location(@company.address_business_card.to_s)
  end

  def update
    @company.layout.update_attributes(params[:id]=>params[:value])
    respond_to do |format|
#      format.html # index.html.erb
#      format.xml
      format.js{render :text=> params[:value].gsub(/\n/,'<br>') }
    end
  end

  def update_image
    @company.layout.update_attributes(params[:layout])
    index
    render :action=>"index"
  end

  def destroy_image
    @layout.update_attribute(params[:id], nil)
    index
    render :action=>"index"
  end

end
