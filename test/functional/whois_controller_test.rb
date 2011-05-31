require 'test_helper'

class WhoisControllerTest < ActionController::TestCase
  test "taken domain" do
    get :check,:domain=>"www.celulaz.com.br"
    assert_equal "true", @response.body
  end
  test "not taken domain" do
    get :check,:domain=>"www.celudoaudhisauhdiasuhlaz.com.br"
    assert_equal "false", @response.body
  end
  test "not taken domain 2" do
    get :check,:domain=>"www.sorvetefeliz.com.br"
    assert_equal "false", @response.body
  end
end
