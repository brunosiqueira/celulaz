# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem, ExceptionNotifiable
  #  rescue_from ActionController::InvalidAuthenticityToken do
  #    cookies.clear
  #    reset_session
  #    redirect_to(login_path)
  #  end
  before_filter :login_required
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'a4432da6f867c3fabb94fcedd11f654b'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  protected

  def set_cross_domain_access
    response.headers["Access-Control-Allow-Origin"] = "*"
  end
  
  def check_comercial_user
    if current_user.is_company?
      flash[:notice] = "O usuário não possui permissão para visualizar esta área."
      redirect_to root_path
    end
  end

  def layout_check_user
    if current_company.nil?
      "new_admin"
    else
      "company"
    end
  end

  def check_company_structure
    @company = current_company.company
    unless @layout = @company.layout
      @layout = @company.create_layout(:name=>@company.razao_social)
      @layout.tabs.create!(:title=>"Home")  if @company.z?
      @layout.create_color(ColorTemplate.find(:first).attributes)
      edit = true
    end
    redirect_to :controller=>:company_profile_management, :action=>:edit, :id=>@company.id if edit
  end

  def load_company
    current = current_company
    if logged_in? && !current.nil?
      @company = current.company
      @layout = @company.layout
    end
  end

  def load_current_company
    load_company
  end

  def login_with_company_z_required
    company = current_company.company
    permission_denied unless CompanyZ.name.eql?(company[:type])
  end

  def block_controller
    redirect_to login_path
  end
  
  def clean_cache
    if logged_as_company?
      Rails.cache.write("#{current_company.login}_content", nil)
      Rails.cache.write("#{current_company.login}_layout", nil)
      logger.info("######### clean cache #########")
    end
  end

  def get_attachment
    return nil if params[:qqfile].nil? || params[:qqfile].blank?
    # get file name
    puts params[:qqfile].class.eql?(String)
    return params[:qqfile] unless params[:qqfile].class.eql?(String)
    file_name = params[:qqfile]
    # get file content type
    att_content_type = (request.content_type.to_s == "") ? "application/octet-stream" : request.content_type.to_s
    # create temporal file
    file = Tempfile.new(file_name)
    # put data into this file from raw post request
    file.print request.raw_post

    # create several required methods for this temporal file
    Tempfile.send(:define_method, "content_type") {return att_content_type}
    Tempfile.send(:define_method, "original_filename") {return file_name}

    # save file into attachment
    return file
  end
end
