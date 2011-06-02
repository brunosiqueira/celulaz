require 'test_helper'

class VisitSchedulerControllerTest < ActionController::TestCase
  test "should show new" do
    get :new
    assert_response :success
  end

  test "should create visit schedule" do
      put :create,:visit_schedule=>{:name=>"siuhsi",:email=>"bruno@diudh.com",:ddd=>"021",:phone=>"212121",
        :address=>"diuashdiauhdiusha",:city=>"oidjsa",:subsidiary_id=>subsidiaries(:one),
        :segment_id=>segments(:alimentacao),:time_to_visit=>"Indiferente"}
      assert_redirected_to login_path
  end

end
