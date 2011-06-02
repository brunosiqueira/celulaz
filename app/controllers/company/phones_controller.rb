class Company::PhonesController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  layout nil

  def create
    @phone = Phone.new params[:phone]
    @company.phones << @phone
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @phone = @company.phones.find params[:id]
    @company.phones.delete @phone
    respond_to do |format|
      format.js
    end
  end
end
