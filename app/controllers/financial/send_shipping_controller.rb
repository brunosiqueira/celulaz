require 'app/util/shipping_file'
class Financial::SendShippingController < ApplicationController
  before_filter :login_as_director_required
  layout "new_admin"
  
  def index
    @shippings = Shipping.find :all, :conditions=>{:status=>"Aberto"}
  end

  def show
    @shipping = Shipping.find params[:id]
  end

  def create
    @shipping = Shipping.find params[:id]
    Shipping.transaction  do
      @shipping.update_attributes!(:processing_date=> Time.now)
      file = ShippingFile::create_file @shipping
      emails=[]
      emails << UserDirector.find(:first).email
      emails << UserAdministrator.find(:first).email
      ShippingMailer.deliver_send_shipping_file emails,@shipping,file
      @shipping.titles.each { |title| 
        title.send!
      }
      @shipping.update_attribute(:file,file)
      @shipping.update_attribute(:status,"Enviado")
    end
    flash[:notice] = "Arquivo gerado com sucesso."
    render :action=>"show"
  rescue Exception=>e
    logger.error e.backtrace.join("\n")
    flash[:error] = "Houve um problema ao gerar o arquivo de remessa: #{e.message}"
    render :action=>"show"
  end

end
