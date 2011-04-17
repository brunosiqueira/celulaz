class Company::ServiceController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  layout false
  #os dois métodos abaixos são responsáveis pela associação de serviços à uma empresa
  def create
    @service = Service.find params[:id]
    unless @company.services.exists?(@service)
      @company.services << @service
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @service = Service.find params[:id]
    @company.services.delete(@service)
    respond_to do |format|
      format.js
    end
  end
end
