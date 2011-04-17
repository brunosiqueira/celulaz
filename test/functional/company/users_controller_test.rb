require 'test_helper'

class Company::UsersControllerTest < ActionController::TestCase
  def setup
    login_as :empresa_valid_2
  end
  test "update success" do
    get :update,{:user=>{:login=>"quentin2"}}
    assert_equal "Usuário Atualizado", flash[:notice]
    assert_response :success
  end

  test "update profile logo" do
    login_as :empresa_valid_2
    get :update_profile_logo,:company=>{}
    assert_response :success
  end
  
  test "update error" do
    get :update,{:user=>{:login=>nil}}
    assert_nil flash[:notice]
    assert_response :success
  end

  test "edit" do
    get :edit
    assert_response :success
  end


end
