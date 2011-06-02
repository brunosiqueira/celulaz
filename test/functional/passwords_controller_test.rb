require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_response :success
  end

  def create
    put :create,:email=>users(quentin).email
    assert_redirected_to login_path
    assert_equal "Um link para reiniciar sua senha foi enviado para o seu e-mail.",flash[:notice]
  end
end
