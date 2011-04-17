require 'test_helper'

class Company::PeopleControllerTest < ActionController::TestCase
  def setup
    login_as :empresa_valid
  end
  def test_should_get_edit
    get :edit, :id => people(:one).id
    assert_response :success
  end

  def test_should_update_person
    put :update, :id => people(:one).id, :person => { }
    assert_equal 'Dados atualizados com sucesso!', flash[:notice]
    assert_response :success
  end

end
