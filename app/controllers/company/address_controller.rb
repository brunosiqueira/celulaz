class Company::AddressController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  layout nil

  def update
    @company.address_business_card.update_attributes(params[:address])
    if @company.address_business_card.valid?
      @address = render_to_string(:partial=>"company/address/address").gsub(/\n/,'').gsub("'","\\'")
    end
    @form = render_to_string(:partial=>"company/address/form").gsub(/\n/,'')
    respond_to do |format|
      format.js
    end
  end
end
