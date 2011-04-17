class Company::PicturesController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :load_components
  after_filter :clean_cache
  layout nil

  def edit
    @picture = @component.pictures.find params[:id]
  end

  def update
    @picture = @component.pictures.find params[:id]
    @picture.update_attributes!((params[:picture] || {} ).merge(:image_attachment=>get_attachment))
    respond_to do |format|
      format.json{render :json=>@picture}
    end
  rescue Exception => err
    respond_to do |format|
      format.json{render(:layout => false , :json => {"error" => err.to_s}.to_json )}
    end
  end

  def destroy
    if params[:picture_ids]
      @component = @layout.components.find(params[:component_id])
      params[:picture_ids].each do |id|
      @component.pictures.delete(@component.pictures.find id)
      end
    end
    render :text=>"{}"
  rescue Exception => err
    render :text=> {"error" => err.to_s}.to_json
  end

  private
  def load_components
    @component = @layout.components.find params[:component_id]
  end
end
