class Company::MessagesController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  
  layout "company"
  
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
    @folder = current_company.inbox
    @folder ||= current_company.folders.find(params[:id])
    @unread_messages = @folder.messages.find_unread_messages :all
    if @message = current_company.received_messages.find_by_id(params[:id])
      if @message.unread?
        @message.update_attribute("read", true)
      end
    else
      render :action=>"not_found"
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
