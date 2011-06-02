require 'test_helper'

class Company::PhonesControllerTest < ActionController::TestCase
  test "create phone" do
    login_as :empresa_valid
    assert_difference("Phone.count",1) do
      get :create, :phone=>{:ddd=>21, :number=>88888888}
    end
    assert_response :success
  end

  test "create phone fail nil" do
    login_as :empresa_valid
    assert_difference("Phone.count",0) do
      get :create, :phone=>{:ddd=>nil, :number=>nil}
    end
    assert !assigns(:phone).valid?
    assert_response :success
  end

  test "create phone fail not number" do
    login_as :empresa_valid
    assert_difference("Phone.count",0) do
      get :create, :phone=>{:ddd=>"3ewew", :number=>"dsafsa"}
    end
    assert !assigns(:phone).valid?
    assert_response :success
  end

  test "create phone fail blank" do
    login_as :empresa_valid
    assert_difference("Phone.count",0) do
      get :create, :phone=>{:ddd=>"", :number=>""}
    end
    assert !assigns(:phone).valid?
    assert_response :success
  end

  test "create phone destroy" do
    login_as :empresa_valid
    assert_difference("Phone.count",-1) do
      get :destroy, :id=>phones(:one).id
    end
    assert_response :success
  end
end
