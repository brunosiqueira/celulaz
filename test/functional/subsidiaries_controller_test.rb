require 'test_helper'

class SubsidiariesControllerTest < ActionController::TestCase
  
  def setup
    login_as :admin    
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:subsidiaries)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_subsidiary
    assert_difference('Subsidiary.count') do
      post :create, :subsidiary => {:title=>'teste' }
    end

    assert_redirected_to subsidiary_path(assigns(:subsidiary))
  end

  def test_should_show_subsidiary
    get :show, :id => subsidiaries(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => subsidiaries(:one).id
    assert_response :success
  end

  def test_should_update_subsidiary
    put :update, :id => subsidiaries(:one).id, :subsidiary => {:title=>"123" }
    assert_redirected_to subsidiary_path(assigns(:subsidiary))
  end

  def test_should_destroy_subsidiary
    assert_difference('Subsidiary.count', -1) do
      delete :destroy, :id => subsidiaries(:no_people).id
    end

    assert_redirected_to subsidiaries_path
  end
  
  def test_should_add_range
    assert_equal 2,subsidiaries(:one).states.size
    get :change_range,{:state=>states(:rs),:id=>subsidiaries(:one)}
    assert_equal 3,subsidiaries(:one).states.size
    assert_response :success
  end

  def test_should_remove_range
    assert_equal 2,subsidiaries(:one).states.size
    get :change_range,{:state=>states(:rio),:id=>subsidiaries(:one)}
    assert_equal 1,subsidiaries(:one).states.size
    assert_response :success
  end
end
