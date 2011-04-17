require 'test_helper'

class TemplateTextsControllerTest < ActionController::TestCase
  def setup
    login_as :admin
  end
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:template_texts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create template_text" do
    assert_difference('TemplateText.count') do
      post :create, :template_text => {:title=>"dadsas",:content=>"fsdcsd" }
    end

    assert_redirected_to template_text_path(assigns(:template_text))
  end

  test "should show template_text" do
    get :show, :id => template_texts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => template_texts(:one).to_param
    assert_response :success
  end

  test "should update template_text" do
    put :update, :id => template_texts(:one).to_param, :template_text => { :title=>"dadsas",:content=>"fsdcsd"}
    assert_redirected_to template_text_path(assigns(:template_text))
  end

  test "should destroy template_text" do
    assert_difference('TemplateText.count', -1) do
      delete :destroy, :id => template_texts(:one).to_param
    end

    assert_redirected_to template_texts_path
  end
end
