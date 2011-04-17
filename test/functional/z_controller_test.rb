require 'test_helper'

class ZControllerTest < ActionController::TestCase
  def test_index
    get :index , :id=>users(:empresa_valid_2).login
    assert assigns(:layout)
    assert assigns(:color)
    assert_response :success
  end

  def test_index_not_found
    get :index , :id=>"asiuhiasuhaiuhsiauhsiauhsiuhai"
    assert_nil assigns(:layout)
    assert_nil assigns(:color)
    assert_redirected_to :controller => "not_found"
  end

  def test_index_from_url_escaped
    get :index , :id=>URI::escape(users(:empresa_valid_2).login)
    assert_response :success
    assert assigns(:layout)
    assert assigns(:color)
  end

end
