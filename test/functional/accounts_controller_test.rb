require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  
  fixtures :users

  def setup
    @controller = AccountsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_should_activate_user
    assert !User.authenticate(users(:gerente_geral).login, 'test').active?
    get :show, :id => users(:gerente_geral).activation_code
    assert_redirected_to login_path
    assert_not_nil flash[:notice]
    assert User.authenticate(users(:gerente_geral).login, 'test').active?
  end
  
  def test_should_not_activate_user_without_key
    get :show
    assert_equal 'Código de ativação não encontrado. Favor, tentar criar outra conta', flash[:notice]
  end

  def test_should_not_activate_user_with_blank_key
    get  :show, :id => ''
    assert_equal 'Código de ativação não encontrado. Favor, tentar criar outra conta', flash[:notice]
  end
end
