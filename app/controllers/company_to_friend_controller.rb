class CompanyToFriendController < ApplicationController
  skip_before_filter :login_required
  
  #TODO criar validacao server do email enviado
  def create
    company = Company.find(params[:company_id])
    #if params[:email_to].nil?
    #  send_failed "Todos os campos são obrigatórios"
    #elsif (params[:email_to] =~ /\w[-.\w]*\@[-\w]+[-.\w]*\.\w+/).nil?
    #send_failed "O email deve ser válido."
    #else
    CompanyMailer.delay.deliver_new_send_to_friend(params[:email_to], company)
    layout = company.layout
    layout.increment_send_to_friend!
    respond_to do |format|
      format.js{render :text=>"true"}
    end
    #end
  end
end
