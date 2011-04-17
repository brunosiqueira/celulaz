require 'test_helper'

class Company::PicturesControllerTest < ActionController::TestCase
  test "update no picture" do
    login_as :empresa_valid
    get :update, :component_id=>components(:gallery), :id=>pictures(:one), :picture=>{:description=>"sou a nova descrição"}
    assert_response :success
    pictures(:one).reload
    assert_equal "sou a nova descrição", pictures(:one).description
  end
end
