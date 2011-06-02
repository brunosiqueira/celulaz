require 'test_helper'

class ResendActivationMailControllerTest < ActionController::TestCase
  test "should show new" do
    get :new
    assert_response :success
  end

  test "should send activation email " do
    put :create , :email=>users(:gerente_geral).email
    assert_equal "E-mail de ativação enviado para #{users(:gerente_geral).email}",flash[:notice]
    assert_redirected_to login_path
  end

  test "should not send activation email " do
    put :create , :email=>users(:quentin).email
    assert_equal "Não foi encontrado o usuário com o email em questão. Talvez o usuário já tenha sido ativado.",flash[:notice]
    assert_redirected_to login_path
  end
end
