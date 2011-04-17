require 'test_helper'

class Financial::ReceiveReturnControllerTest < ActionController::TestCase
  def setup
    login_as :admin
  end


  test "should show new" do
    get :new
    assert_response :success
  end

  test "should create return" do
    file = File.new "test/resources/return/COB01.TXT"
    put :create, :return=>file
    assert_response :success
    assert assigns(:titles)
    assert_equal "Não foi possível realizar a operação. Nenhum título foi localizado durante o processamento.",flash[:error] 
  end

  test "should not create return invalid file" do
    file = File.new "test/resources/return/COBERROR.TXT"
    put :create, :return=>file
    assert_response :success
    assert assigns(:titles)
    assert_equal "Formato de arquivo de retorno inválido.",flash[:error]
  end
end
