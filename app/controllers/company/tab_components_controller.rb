class Company::TabComponentsController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company,:except=>:new
  before_filter :login_with_company_z_required
  before_filter :load_component
  layout nil

  def create
    unless @component.tab_component.nil?
      TabComponent.delete @component.tab_component.id
    end
    @component.tab_component = TabComponent.new params[:tab_component]
    respond_to do |format|
      format.json{render :text=>"true"}
    end
  end
  def update
    unless @component.tab_component.nil?
      @component.tab_component.update_attribute :full_line, params[:full_line]
    end
    respond_to do |format|
      format.json{render :text=>"true"}
    end
  end

  def destroy
    unless @component.tab_component.nil?
      TabComponent.delete @component.tab_component.id
    end
    respond_to do |format|
      format.json{render :text=>"true"}
    end
  end
  private
  def load_component
    @component = @layout.components.find(:first, :conditions=>{:id=>params[:id]}, :include=>:tab_component)
  end
end
