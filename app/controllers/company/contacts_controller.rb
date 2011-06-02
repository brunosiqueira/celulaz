class Company::ContactsController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :create_address_not_exist
  layout nil
  def edit
    #testar para ver se @company ja tem endereco. Se nao tive, criar
    render :layout=>"company"
  end
  
  def index
    @contacts = current_company.company.friends
    respond_to do |format|
      format.js
    end
  end

  private
  def create_address_not_exist
    if @layout.address_site.nil? && @company.z?
      @layout.update_attributes :address_site=>Address.new(@company.address_business_card.attributes)
    end
  end

end
