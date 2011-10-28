class Company::ConstructionController < ApplicationController
  before_filter :login_with_company_required
  before_filter :login_with_company_z_required
  before_filter :load_company
  before_filter :check_template
  before_filter :unread_messages, :only => [:index]

  layout "new_layout"
  
  def index
    @site_published = current_company.company.user.preference[:site_published] unless current_company.company.user.preference.nil?
  end

  def content
    @tabs = @layout.tabs
    @components = @layout.components_no_tabs
    render :text=>render_to_string(:template=>"/company/construction/content.json",:layout=>false).gsub(/\n/,'').gsub(/\r/,'').gsub(/\\/,'')

  end
  private
  def check_template
    redirect_to :controller=>"company/identity",:action=>"new" if @layout.architecture_type.nil?
  end
end
