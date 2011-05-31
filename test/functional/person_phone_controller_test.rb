require 'test_helper'

class PersonPhoneControllerTest < ActionController::TestCase
  def test_create_success
    login_as :admin_web
    assert_difference('Phone.count') do
      put :create,{:id=>people(:admin_web).id, :phone=>{:number=>12345678, :ddd=>021}}
    end
    assert_select_rjs :insert, :bottom, "telefones"
  end

  def test_create_failed
    login_as :admin_web
    assert_no_difference('Phone.count') do
      put :create,{:id=>people(:admin_web).id, :phone=>{:number=>""}}
    end
    assert_response :success
  end

  def test_destroy_success
    login_as :admin_web
    id = phones(:one).id
    assert_difference('Phone.count',-1) do
      put :destroy,{:id=>phones(:two).id}
    end
    assert_response :success
  end
end
