class SystemModules::Mailbox::MessagesController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :unread_messages, :only => [:show]
  
  layout "new_layout"
  
  def create
    parameters = params[:message]
    if params[:public_profile]
      parameters = params[:message].merge(:body=>params[:value])
    end
    @message = current_company.sent_messages.build(parameters)
    respond_to do |format|
      if @message.save
        format.js{render :text=> "Mensagem enviada com sucesso." }
      else
        format.js{render :text=> "Ocorreu um erro no envio da mensagem." }
      end
    end
  end
  
  def reply
    @original = current_company.received_messages.find(params[:message][:id])
    @message = current_company.sent_messages.build(:to => [@original.sender.id], :subject => @original.subject, :body => params[:message][:body])
    if @message.save
      @original.answer_id = @message.id
      @original.save
    end
    render :text=>true
  end

  def not_found

  end

  def show
    if params[:message_origin] == "inbox"
      @folder = current_company.inbox
      @unread_messages = @folder.messages.find_unread_messages :all
      @message = current_company.received_messages.find_by_id(params[:id])
      if @message
        @message.update_attribute("read", true) if @message.unread?
      else
        render :action=>"not_found"
      end
    else
      @folder = current_company.inbox
      @unread_messages = @folder.messages.find_unread_messages :all
      @message = current_company.sent_messages.find(params[:id])
      if @message
        render :action => "show_sent_message"
      else
        render :action=>"not_found"
      end
    end
  end

  def destroy
    if params[:id] != ""
      params[:id].split(",").each do | id |
        if message = current_company.received_messages.find_by_id(id)
          message.update_attribute("deleted", true)
        elsif message = current_company.sent_messages.find_by_id(id)
          message.update_attribute("deleted_sent_box", true)
        end
      end
      respond_to do |format|
        format.js{render :text=>"true"}
      end
    end
  end
end
