module AuthenticatedSystem
  protected
  
  # Returns true or false if the user is logged in.
  # Preloads @current_user with the user model if they're logged in.
  def logged_in?
    !!current_user
  end

  def logged_as_company?
    !!current_company
  end

  def logged_as_company_z?
    !!current_company && current_company.company[:type].eql?("CompanyZ")
  end

  def redirect_to_user_role
    if current_company
      respond_to do |format|
        format.html { redirect_to(company_root_path)}
      end
    else
      redirect_to :controller=>"users", :action=>"show"
    end
  end

  def current_company
    return nil if !logged_in?
    @current_company ||= UserCompany.name.eql?(current_user[:type]) ? current_user : UserCompany.find_by_id(session[:current_company_id])
  end
  
  # Accesses the current user from the session.
  # Future calls avoid the database because nil is not equal to false.
  def current_user
    @current_user ||= (login_from_session || login_from_basic_auth || login_from_cookie) unless @current_user == false
  end
  
  # Store the given user id in the session.
  def current_user=(new_user)
    session[:user_id] = new_user ? new_user.id : nil
    @current_user = new_user || false
  end
  
  # Check if the user is authorized
  #
  # Override this method in your controllers if you want to restrict access
  # to only a few actions or if you want to check if the user
  # has the correct rights.
  #
  # Example:
  #
  #  # only allow nonbobs
  #  def authorized?
  #    current_user.login != "bob"
  #  end
  def authorized?
    logged_in?
  end
  
  def login_required
    authorized? || access_denied
  end

  def login_with_company_required
     (authorized? && current_company) || access_denied
  end

  def login_as_director_required
    (authorized? && (current_user.has_role?(UserDirector.name) || current_user.has_role?(UserAdministrator.name))) || access_denied
  end

  def login_as_financial_user_required
    (authorized? && (current_user.has_role?(UserDirector.name) || current_user.has_role?(UserAdministrator.name))) || access_denied
  end
  
  def not_logged_in_required
    !logged_in? || permission_denied
  end
  
  def not_logged_or_not_company_logged_required
    if logged_in? && @current_user.has_role?(UserCompany.name)
      permission_denied
    end
  end

  def not_company_logged
    if !logged_in? || @current_company
      permission_denied
    end
  end
  
  def check_role(role)
    unless logged_in? && @current_user.has_role?(role)
      if logged_in?
        permission_denied
      else
        store_referer
        access_denied
      end
    end
  end
  
  
  def permission_denied
    respond_to do |format|
      format.html do
        #Put your domain name here ex. http://www.example.com
        domain_name = SITE_URL
        http_referer = session[:refer_to]
        if http_referer.nil?
          store_referer
          http_referer = ( session[:refer_to] || domain_name )
        end
        flash[:error] = "Você não possui permissão para completar esta ação"
        #The [0..20] represents the 21 characters in http://localhost:3000
        #You have to set that to the number of characters in your domain name
        if http_referer[0..20] != domain_name
          session[:refer_to] = nil
          redirect_to root_path
        else
          redirect_to_referer_or_default(root_path)
        end
      end
      format.any do
        headers["Status"]           = "Unauthorized"
        headers["WWW-Authenticate"] = %(Basic realm="Web Password")
        render :text => "You don't have permission to complete this action.", :status => '401 Unauthorized'
      end
    end
  end
  
   
  def store_referer
    session[:refer_to] = request.env["HTTP_REFERER"]
  end

  def redirect_to_referer_or_default(default)
    redirect_to(session[:refer_to] || default)
    session[:refer_to] = nil
  end
  
  # Redirect as appropriate when an access request fails.
  #
  # The default action is to redirect to the login screen.
  #
  # Override this method in your controllers if you want to have special
  # behavior in case the user is not authorized
  # to access the requested action.  For example, a popup window might
  # simply close itself.
  def access_denied
    respond_to do |format|
      format.html do
        store_location
        redirect_to root_path
      end
      format.any do
        request_http_basic_authentication 'Web Password'
      end
    end
  end
  
  # Store the URI of the current request in the session.
  #
  # We can return to this location by calling #redirect_back_or_default.
  def store_location
    session[:return_to] = request.request_uri
  end
  
  # Redirect to the URI stored by the most recent store_location call or
  # to the passed default.
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  # Inclusion hook to make #current_user, #logged_in? and #current_company
  # available as ActionView helper methods.
  def self.included(base)
    base.send :helper_method, :current_user, :logged_in?, :current_company,:logged_as_company_z?
  end
  
  # Called from #current_user.  First attempt to login by the user id stored in the session.
  def login_from_session
    self.current_user = User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
  # Called from #current_user.  Now, attempt to login by basic authentication information.
  def login_from_basic_auth
    authenticate_with_http_basic do |username, password|
      self.current_user = User.authenticate(username, password)
    end
  end
  
  # Called from #current_user.  Finaly, attempt to login by an expiring token in the cookie.
  def login_from_cookie
    user = cookies[:auth_token] && User.find_by_remember_token(cookies[:auth_token])
    if user && user.remember_token?
      cookies[:auth_token] = { :value => user.remember_token, :expires => user.remember_token_expires_at }
      self.current_user = user
    end
  end
end
