require 'test_helper'

class PeopleConfirmControllerTest < ActionController::TestCase
  # 2 usuários superiores devem confirmar o cadastro do usuário
  def test_first_confirm_person_signup
    login_as :admin_web
    get :create,{:id=>people(:empresa).id}
    assert_equal flash[:notice], "Confirmação realizada com sucesso!"
    assert users(:admin_web),assigns(:person).user_create
    assert_nil assigns(:person).user_confirm
    assert_response :success
  end

  def test_second_confirm_person_signup
    login_as :gerente_segmento
    get :create,{:id=>people(:empresa_first_confirm).id}
    assert users(:gerente_segmento),assigns(:person).user_confirm
    assert_equal flash[:notice], "Confirmação realizada com sucesso!"
    assert_response :success
  end

  #O pefil da segunda confirmação deve ser superior ao da primeira
  def test_second_confirm_person_signup_failed
    login_as :admin_web
    get :create,{:id=>people(:empresa_first_confirm).id}
    assert_nil assigns(:person).user_confirm
    assert_equal flash[:notice], "Não foi possível confirmar a validade da pessoa com o usuário corrente."
    assert_response :success
  end

  def test_show
    login_as :admin_web
    get :show, :id=>people(:empresa_first_confirm).id
    assert_response :success
    assert assigns(:person)
  end

  def test_people_to_confirm_non_companies
    login_as :admin
    get :index
    assert_equal 3,assigns(:people).size
  end

  def test_people_to_confirm_companies
    login_as :admin
    get :index_companies
    assert_equal 2,assigns(:companies).size
  end

  def test_people_to_confirm_non_companies_as_gm
    login_as :gerente_geral
    get :index
    assert_equal 2,assigns(:people).size
  end

  def test_people_to_confirm_companies_as_gm
    login_as :gerente_geral
    get :index_companies
    assert_equal 1,assigns(:companies).size
  end


  def test_edit
    login_as :admin_web
    get :edit, :id=>people(:empresa_first_confirm).id
    assert_response :success
    assert assigns(:person)
    assert assigns(:company)
  end

  def test_edit_seller
    login_as :admin_web
    get :edit, :id=>people(:seller).id
    assert_response :success
    assert assigns(:person)
    assert_nil assigns(:company)
  end


  def test_should_destroy_person
    login_as :admin
    assert_difference('Person.count', -1) do
      delete :destroy, :id => people(:seller).id
    end

    assert_redirected_to :action=>"index"
  end

end
