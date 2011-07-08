class SystemModules::Mailbox::SentboxController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :unread_messages
  
  layout "company"
  
  def show
    @messages = current_company.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
    @folder = current_company.inbox
    @unread_messages = @folder.messages.find_unread_messages :all
  end
end
