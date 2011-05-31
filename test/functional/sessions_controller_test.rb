require File.dirname(__FILE__) + '/../test_helper'
require 'sessions_controller'

# Re-raise errors caught by the controller.
class SessionsController; def rescue_action(e) raise e end; end

class SessionsControllerTest < ActionController::TestCase
#  fixtures :users

  def test_should_login
    post :create, :login => 'quentin', :password => 'test'
    assert session[:user_id]
    assert_redirected_to :controller=>"users",:action=>"show"
  end

  def test_should_login_with_email
    post :create, :login => 'quentin@example.com', :password => 'test'
    assert session[:user_id]
    assert_redirected_to :controller=>"users",:action=>"show"
  end

  def test_should_login_as_company
    post :create, :login => 'empresa_valid', :password => 'test'
    assert session[:user_id]
    assert_redirected_to company_root_path
  end

  def test_should_fail_login
    post :create, :login => 'quentin', :password => 'bad password'
    assert_nil session[:user_id]
    assert_redirected_to :controller=>'main'
  end

  def test_should_fail_login_confirm_user
    post :create, :login => 'empresa', :password => 'test'
    assert_nil session[:user_id]
    assert_redirected_to :controller=>'main'
    assert_equal "Seus dados pessoais ainda não foram confirmados pela administração.",flash[:error]
  end

  def test_should_logout
    login_as :quentin
    assert @request.session[:user_id]
    get :destroy
    assert_nil session[:user_id]
    assert_response :redirect
  end

  def test_should_remember_me
    post :create, :login => 'quentin', :password => 'test', :remember_me => "1"
    assert_not_nil @response.cookies["auth_token"]
  end

  def test_should_not_remember_me
    post :create, :login => 'quentin', :password => 'test', :remember_me => "0"
    assert_nil @response.cookies["auth_token"]
  end
  
  def test_should_delete_token_on_logout
    login_as :quentin
    get :destroy
    assert_nil @response.cookies["auth_token"]
  end

  def test_should_login_with_cookie
    users(:quentin).remember_me
    @request.cookies["auth_token"] = cookie_for(:quentin)
    get :new
    assert @controller.send(:logged_in?)
  end

  def test_should_fail_expired_cookie_login
    users(:quentin).remember_me
    users(:quentin).update_attribute :remember_token_expires_at, 5.minutes.ago
    @request.cookies["auth_token"] = cookie_for(:quentin)
    get :destroy
    assert !@controller.send(:logged_in?)
    assert_redirected_to root_path
  end

  def test_should_fail_cookie_login
    users(:quentin).remember_me
    @request.cookies["auth_token"] = auth_token('invalid_auth_token')
    get :destroy
    assert !@controller.send(:logged_in?)
    assert_redirected_to root_path
  end

  protected
  def auth_token(token)
#    CGI::Cookie.new('name' => 'auth_token', 'value' => token)
    token
  end
    
  def cookie_for(user)
    auth_token users(user).remember_token
  end
end
