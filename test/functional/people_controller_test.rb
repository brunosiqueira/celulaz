require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  
  def setup
    login_as :admin
  end
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_person
      assert_difference('Person.count') do
        post :create, :person => {:name=>'Bruno Siqueira',:cpf=>'356.726.002-20', :rg=> 'MyString',
          :rg_exp=> 'MyString', :rg_exp_date=> '2008-09-09', :date_birth=> '2008-09-09',:subsidiary_id=>subsidiaries(:one),:state=>states(:acre)}
    end

    assert_redirected_to person_path(assigns(:person))
  end

  def test_should_create_person_with_admin_web
    login_as :admin_web
    assert_difference('Person.count') do
      post :create, :person => {:name=>'Bruno Siqueira',:cpf=>'356.726.002-20', :rg=> 'MyString',
        :rg_exp=> 'MyString', :rg_exp_date=> '2008-09-09', :date_birth=> '2008-09-09'}
    end
    assert_redirected_to person_path(assigns(:person))
    assert_equal assigns(:person).subsidiary, people(:admin_web).subsidiary
  end


  def test_should_show_person
    get :show, :id => people(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => people(:one).id
    assert_response :success
  end

  def test_should_update_person
    put :update, :id => people(:one).id, :person => { }
    assert_redirected_to person_path(assigns(:person))
  end

  def test_should_destroy_person
    assert_difference('Person.count', -1) do
      delete :destroy, :id => people(:seller).id
    end
  
    assert_redirected_to people_path
  end
  

end
