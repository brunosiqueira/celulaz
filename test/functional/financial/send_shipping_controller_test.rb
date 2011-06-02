require 'test_helper'

class Financial::SendShippingControllerTest < ActionController::TestCase
  def setup
    login_as :admin
  end

  test "index" do
    get :index
    assert_response :success
    assert assigns(:shippings)
  end

  test "should generate and send file" do
    put :create, :id=>shippings(:with_titles)
    assert_response :success
    assert_nil flash[:error]
    assert_equal "Arquivo gerado com sucesso.", flash[:notice]
    shippings(:with_titles).titles.reload
    shippings(:with_titles).titles.each { |title|
      assert_equal "Enviado",title.status
    }
    assert assigns(:shipping)
    shippings(:with_titles).reload
    assert_equal "Enviado",shippings(:with_titles).status
    assert shippings(:with_titles).file_name
  end

  test "should show shipping" do
    get :show,:id=>shippings(:with_titles)
    assert_response :success
    assert assigns(:shipping)
  end
end
