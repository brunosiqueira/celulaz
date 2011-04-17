class Company::LayoutContactController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  after_filter :clean_cache
  layout nil
  
  def update_component
    @component_type = params[:component_type]
    
    if params[:address]
      @company.layout.address_site.update_attributes(params[:address])
    elsif params[:layout]
      @company.layout.update_attributes(params[:layout])
    end
    
    @component_view = render_to_string(:partial=>"company/layout_contact/#{@component_type}_view").gsub(/\n/,'').gsub("'","\\'")
    @component_form = render_to_string(:partial=>"company/layout_contact/#{@component_type}_form").gsub(/\n/,'')
    
    respond_to do |format|
      format.js { render :file => "company/layout_contact/update_component"}
    end
    
  end

  def update_attribute
    @layout.address_site.update_attribute(params[:field],params[:value])
    render :text=>"true"
  end
  
  def add_phone
    @phone = Phone.new params[:phone]
    @company.layout.phones << @phone
    @phones = render_to_string(:partial=>"company/layout_contact/phones_view").gsub(/\n/,'').gsub("'","\\'")
    respond_to do |format|
      format.js
    end
  end
  
  def destroy_phone
    @phone = Phone.find params[:id]
    @phone.delete
    render :text => "Apagou"
  end
  
end
