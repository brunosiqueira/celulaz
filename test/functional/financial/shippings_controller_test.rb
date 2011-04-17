require 'test_helper'

class Financial::ShippingsControllerTest < ActionController::TestCase
  def setup
    login_as :admin
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shippings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipping" do
    assert_difference('Shipping.count') do
      post :create, :shipping => { }
    end

    assert_redirected_to financial_shipping_path(assigns(:shipping))
  end

  test "should show shipping" do
    get :show, :id => shippings(:with_titles).id
    assert_response :success
    assert assigns(:titles)
  end

  test "should get edit" do
    get :edit, :id => shippings(:with_titles).id
    assert_response :success
  end

  test "should update shipping" do
    put :update, :id => shippings(:with_titles).id, :shipping => { }
    assert_redirected_to financial_shipping_path(assigns(:shipping))
    assert_equal flash[:notice], 'Remessa atualizada com sucesso'
    assert assigns(:titles)
  end

  test "should destroy shipping" do
    assert_difference('Shipping.count', -1) do
      delete :destroy, :id => shippings(:with_titles).id
    end

    assert_redirected_to financial_shippings_path
  end
end
