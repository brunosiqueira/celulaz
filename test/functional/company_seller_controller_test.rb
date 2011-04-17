require 'test_helper'

class CompanySellerControllerTest < ActionController::TestCase
  def setup
    @controller = CompanySellerController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as :gerente_segmento
  end
  
  # Prepara a associação entre uma empresa e um vendedor.
  def test_new
    get :new , {:id=>companies(:empresa).id}
    assert_response :success
    assert_not_nil assigns(:company)
    assert_equal assigns(:company), companies(:empresa)
    assert_not_nil assigns(:sellers)
  end

  # Não encontra a empresa em questão
  def test_new_failed
    get :new , {:id=>"XXXXX"}
    assert_redirected_to :controller=>:company_management, :action => "index"
    assert_nil assigns(:company)
    assert_nil assigns(:sellers)
    assert_equal I18n.t("company.messages.not_found"), flash[:notice]
  end

  def test_create
    get :create,{:id=>companies(:empresa).id, :company=>{:person_id=>people(:one).id}}
    assert_redirected_to :controller=>"company_management", :action => "index"
    assert_equal assigns(:company).seller,people(:one)
    assert flash[:notice] = "Empresa associada ao vendedor com sucesso."
  end

  def test_destroy
    assert companies(:empresa_valid).seller
    get :destroy, :id=>companies(:empresa_valid)
    companies(:empresa_valid).reload
    assert_redirected_to :controller=>"company_management", :action => "index"
    assert_nil companies(:empresa_valid).seller
  end
end
