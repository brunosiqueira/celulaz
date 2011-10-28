class Company::SeoController < ApplicationController
  before_filter :login_with_company_required
  before_filter :login_with_company_z_required
  before_filter :load_company
  before_filter :unread_messages, :only => [:edit]
  layout "new_layout"

  def edit
  end

 def update
    @layout.update_attributes params[:layout]
    render :action=>"edit"
 end

end
