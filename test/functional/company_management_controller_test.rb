require 'test_helper'

class CompanyManagementControllerTest < ActionController::TestCase
  def setup
    login_as :admin
  end

  def test_index_gerente_geral
    login_as :gerente_geral
    get :index
    assert_response :success
    assert_equal assigns(:companies), [companies(:empresa)]
  end

  def test_index_admin
    get :index
    assert_response :success
    assert_equal assigns(:companies), Company.find(:all)
  end

  def test_index_adm_web
    login_as :admin_web
    get :index
    assert_response :success
    assert_equal 1, assigns(:companies).size
    assert_equal [companies(:empresa)],assigns(:companies)
  end

  def test_loggin_as_company
    get :loggin_as_company,:id=>users(:empresa_valid).id
    assert_redirected_to root_path
    assert_equal session[:current_company_id],users(:empresa_valid).id
  end

  def test_loggin_as_company_with_admin_web
    login_as :admin_web
    get :loggin_as_company,:id=>users(:empresa).id
    assert_redirected_to root_path
    assert_equal session[:current_company_id],users(:empresa).id
  end

  def test_loggin_as_company_with_general_admin
    login_as :gerente_geral
    get :loggin_as_company,:id=>users(:empresa).id
    assert_redirected_to root_path
    assert_equal session[:current_company_id],users(:empresa).id
  end

  def test_loggin_as_company_failed
    get :loggin_as_company,:id=>"XXX"
    assert_redirected_to :action=>:index
    assert_nil session[:current_company_id]
  end

  def test_loggout_as_company
    get :loggout_as_company
    assert_redirected_to root_path
    assert_nil session[:current_company_id]
  end

  def test_change_type_to_s
    assert_equal CompanyZ.name,companies(:empresa_valid_2)[:type]
    get :change_type_to_s, :id=>companies(:empresa_valid_2)
    assert assigns(:user)
    assert_response :success
  end

  def test_change_type_to_z
    assert_equal CompanyS.name,companies(:empresa_first_confirm)[:type]
    get :change_type_to_z, :id=>companies(:empresa_first_confirm),:company=>{:register_number=>"TESTESTESTES"}
    assert assigns(:user)
    assert assigns(:company)
    assert_equal "TESTESTESTES", assigns(:company).register_number
    assert_response :success
  end

  def test_change_type_to_z_2
    assert_equal CompanyS.name,companies(:empresa_first_confirm)[:type]
    get :change_type_to_z, :id=>companies(:empresa_first_confirm),:company=>{:register_number=>"TESTESTESTES", :parcel=>1,:value=>50.0},:person=>{:cpf=>"099.033.907-69"}
    assert assigns(:user)
    assert assigns(:company)
    assert assigns(:person)
    assert_equal "TESTESTESTES", assigns(:company).register_number
    assert_equal CompanyZ.name, assigns(:company)[:type]
    assert_response :success
  end

  def test_change_to_z
    assert_equal CompanyS.name,companies(:empresa_first_confirm)[:type]
    get :change_to_z, :id=>companies(:empresa_first_confirm)
    assert_response :success
  end

  def test_should_edit
    put :edit, :id => companies(:empresa_valid)
    assert_response :success
  end

  def test_should_update_company
    put :update, :id => companies(:empresa_valid), :company => { }
    assert_redirected_to :action=>"show",:id=>companies(:empresa_valid)
    assert_equal 'Empresa atualizada com sucesso!', flash[:notice]
  end
end
