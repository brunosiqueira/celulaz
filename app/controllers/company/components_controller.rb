class Company::ComponentsController < ApplicationController
  before_filter :login_with_company_required
  before_filter :login_with_company_z_required
  before_filter :load_company,:except=>:new
  after_filter :clean_cache
  layout nil
  MAP_TYPE = {"texto"=>"ComponentText","video"=>"ComponentVideo","imagem"=>"ComponentPicture","galeria"=>"ComponentGallery","formulario"=>"ComponentForm"}
  def new
    render :template=>"/company/components/new_#{MAP_TYPE[params[:tipo]].underscore}"
  end

  def edit
    @component = @layout.components.find params[:id]
    render :template=>"/company/components/edit_#{@component[:type].underscore}"
  end

  def create
    parameters = params[:component]
    if attachment = get_attachment
      parameters.merge!(:image_attachment=>attachment)
    end
    @component = MAP_TYPE[params[:tipo]].constantize.new(parameters)
    @layout.components << @component
    render :text=>@component.to_json
  rescue Exception => err
    render :text=> {"error" => err.to_s}.to_json
  end

  def destroy
    if params[:component_ids]
      params[:component_ids].each { |id| @layout.components.delete(@layout.components.find id)  }
    elsif component = @layout.components.find(params[:component_id])
      @layout.components.delete(component)
    end
    render :text=>"{}"
  rescue Exception => err
    render :text=> {"error" => err.to_s}.to_json
  end

  def update
    parameters = params[:component]
    if attachment = get_attachment
      parameters.merge!(:image_attachment=>attachment)
    end
    @component = @layout.components.find params[:id]
    @component.update_attributes!(parameters)
    render :text=>@component.to_json
  rescue Exception => err
    render :text=> {"error" => err.to_s}.to_json
  end
end
