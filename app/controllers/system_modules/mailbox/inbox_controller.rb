class SystemModules::Mailbox::InboxController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :unread_messages
  layout "company"
  
  def show
    @messages = current_company.inbox.messages.paginate_not_deleted :all, :per_page => 10, :page => params[:page],
      :include => :message, :order => "messages.created_at DESC"
  end
end