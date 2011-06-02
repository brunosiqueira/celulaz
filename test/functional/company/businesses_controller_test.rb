require 'test_helper'

class Company::BusinessesControllerTest < ActionController::TestCase
  def setup
    login_as :empresa_valid_2
  end
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:businesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business" do
    assert_difference('Business.count') do
      post :create, :business => {:value=>33.4, :total=>4,:per_company=>2,:title=>"dhdhdhh"  }
    end

    assert_redirected_to company_business_path(assigns(:business))
  end

  test "should show business" do
    get :show, :id => businesses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => businesses(:one).to_param
    assert_response :success
  end

  test "should update business" do
    put :update, :id => businesses(:one).to_param, :business => {:value=>33.4, :per_company=>2,:title=>"dhdhdhh" }
    assert_redirected_to company_business_path(assigns(:business))
  end

  test "should destroy business" do
    assert_difference('Business.count', -1) do
      delete :destroy, :id => businesses(:one).to_param
    end

    assert_redirected_to company_businesses_path
  end

  test "buy business" do
    login_as :empresa_valid
    assert_difference('BusinessCompany.count', 1) do
      get :buy, :id => businesses(:one).to_param
    end
  end
end
