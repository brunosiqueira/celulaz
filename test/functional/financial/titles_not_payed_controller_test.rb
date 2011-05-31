require 'test_helper'

class Financial::TitlesNotPayedControllerTest < ActionController::TestCase
  def setup
    login_as :empresa_valid
  end

  test "should show index" do
    get :index,:company_id=>companies(:empresa_valid)
    assert_response :success
    assert assigns(:titles)
  end

  test "should show title boleto" do
    get :show,:company_id=>companies(:empresa_valid),:id=>titles(:one)
    assert_response :success
  end
end
