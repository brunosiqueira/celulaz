class Company::LayoutController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  after_filter :clean_cache
  layout nil

  def index
  end

  def top
  end

  def background
  end

  def update_attribute
    @layout.update_attributes(params[:id].to_sym=>params[:value])
    render :text=>params[:value]
  end
  def update_background_top
    path = params[:id].gsub('_small','')
    @layout.update_attribute(:background_top,path)
    render :text=>path
  end
  def update_background
    path = params[:id].gsub('_small','')
    @layout.update_attribute(:background_file_name,path)
    render :text=>path
  end
  def update_top
    path = params[:id].gsub('_small','')
    @layout.update_attribute(:background_top,path)
    render :text=>path
  end

  def upload_background
    @background = @layout.backgrounds.create(:my_background=>get_attachment)
    @layout.update_attribute :background_file_name, @background.my_background.url(:original)
    render :text=>"{\"url\": \"#{@background.my_background.url(:original)}\"}"
  rescue Exception => err
    render :text=> {"error" => err.to_s}.to_json
  end
  

  def upload_background_top
    @background = @layout.background_tops.create(:background_top=>get_attachment)
    @layout.update_attribute :background_top, @background.background_top.url(:original)
    render :text=>"{\"url\": \"#{@background.background_top.url(:original)}\"}"
  rescue Exception => err
    render :text=> {"error" => err.to_s}.to_json
  end

  def update_background_property
    if "true".eql?(params[:value])
      @layout.update_attribute(params[:id].to_sym,true)
    else
      @layout.update_attribute(params[:id].to_sym,false)
    end
    render :text=>"{\"repeat_x\": \"#{@layout.repeat_background_x ? "true" : "false"}\", \"repeat_y\": \"#{@layout.repeat_background_y ? "true" : "false"}\", \"centralize\": \"#{@layout.centralize_background ? "true" : "false"}\"}"
  end
  
  def delete_background_top
    @bg_top = BackgroundTop.find(params[:id])
    @bg_top.destroy
    render :text => "ok"
  end
  
  def delete_background
    @bg = Background.find(params[:id])
    @bg.destroy
    render :text => "ok"
  end
end
