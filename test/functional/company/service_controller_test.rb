require 'test_helper'

class Company::ServiceControllerTest < ActionController::TestCase


  def test_create_service
    login_as :empresa_valid
    get :create,  :id=>services(:one).id
    companies(:empresa_valid).reload
    assert_equal services(:one), companies(:empresa_valid).services.first
    assert_response :success
  end

   def test_destroy_service
    login_as :empresa_valid
    companies(:empresa_valid).services << services(:one)
    companies(:empresa_valid).save!
    assert_equal services(:one), companies(:empresa_valid).services.first
    get :destroy,:id=>services(:one).id
    companies(:empresa_valid).reload
    assert companies(:empresa_valid).services.empty?
    assert_response :success
  end

end
