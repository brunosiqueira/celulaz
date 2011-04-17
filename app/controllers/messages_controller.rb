class MessagesController < ApplicationController
  skip_before_filter :login_required
  protect_from_forgery :except => [:create]
  skip_before_filter :verify_authenticity_token
  before_filter :set_cross_domain_access
  def create
    parameters = params[:message]
    if params[:public_profile]
      name      = "Nome: " + (params[:public_profile][:name].blank? ? "" : params[:public_profile][:name])
      address   = "Endereço:" + (params[:public_profile][:address].blank? ? "" : params[:public_profile][:address])
      phone     = "Telefone: " + (params[:public_profile][:ddd].blank? ? "" : params[:public_profile][:ddd] )
      phone     = phone + (params[:public_profile][:number].blank? ? "" : params[:public_profile][:number] )
      new_body  =  name + "<br />" + address + "<br />" + phone + "<br />" + params[:message][:body]
      params[:message][:body] = new_body
    end
    @message = logged_in? ? current_user.sent_messages.build(parameters) : Message.new(parameters)
      if @message.save
        render :text=>"true"
      else
        render :text=>"false"
      end
  end
end