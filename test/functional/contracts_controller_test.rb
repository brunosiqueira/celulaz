require 'test_helper'

class ContractsControllerTest < ActionController::TestCase
  def setup
    login_as :admin
  end

  test "should get index" do
    get :index,:company_id=>companies(:empresa_first_confirm)
    assert_response :success
    assert_not_nil assigns(:contracts)
    assert_not_nil assigns(:company)
    assert_equal assigns(:contracts),companies(:empresa_first_confirm).contracts
  end

  test "should get new" do
    get :new,:company_id=>companies(:empresa_first_confirm)
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post :create, {:company_id=>companies(:empresa_first_confirm),:contract => {:parcel=>12,:value=>50.0, :initial_date=> "2008-02-12", :end_date=>"2009-02-12" ,:status=>"Aberto"}}
    end

    assert_redirected_to company_contract_url(:id=>assigns(:contract), :company_id=>companies(:empresa_first_confirm))
  end

  test "should not create contract" do
    assert_difference('Contract.count',0) do
      post :create, {:company_id=>companies(:empresa_first_confirm),:contract => { }}
    end
    assert_response :success
  end

  test "should show contract" do
    get :show, {:company_id=>companies(:empresa_first_confirm),:id => contracts(:one)}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:company_id=>companies(:empresa_first_confirm),:id => contracts(:one)}
    assert assigns(:contract)
    assert assigns(:company)
    assert_response :success
  end

  test "should update contract" do
    put :update, {:company_id=>companies(:empresa_first_confirm), :id => contracts(:one), :contract => { }}
    assert_redirected_to company_contract_url(:id=>assigns(:contract),:company_id=>companies(:empresa_first_confirm))
  end

  test "should destroy contract" do
    assert_difference('Contract.count', -1) do
      delete :destroy, {:company_id=>companies(:empresa_first_confirm),:id => contracts(:three)}
    end

    assert_redirected_to company_contracts_path(companies(:empresa_first_confirm))
  end

end
