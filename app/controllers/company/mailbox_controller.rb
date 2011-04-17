class Company::MailboxController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  
  layout "company"
  
  def index
    @folder = current_company.inbox
    @messages = @folder.messages.paginate_not_deleted :all, :per_page => 10, :page => params[:page],
      :include => :message, :order => "messages.created_at DESC"
    @unread_messages = @folder.messages.find_unread_messages :all
  end
end
