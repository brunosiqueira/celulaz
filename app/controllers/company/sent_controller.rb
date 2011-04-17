class Company::SentController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
#  before_filter :check_browser, :only => [:index, :show]
  
  layout "company"
  
  def index
    @messages = current_company.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
    @folder = current_company.inbox
    @folder ||= current_company.folders.find(params[:id])
    @unread_messages = @folder.messages.find_unread_messages :all
  end

  def show
    @message = current_company.sent_messages.find(params[:id])
    @folder = current_company.inbox
    @folder ||= current_company.folders.find("Inbox")
    @unread_messages = @folder.messages.find_unread_messages :all
  end
end
