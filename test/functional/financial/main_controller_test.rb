require 'test_helper'

class Financial::MainControllerTest < ActionController::TestCase
  def setup
    login_as :admin
  end
  
  test "generate titles" do
    assert_difference("Title.count") do
      get :generate_new_titles,:month=>Time.now.month
    end
    assert_equal Time.now.month.next, contracts(:two).titles.last.due_date.month
  end

  test "generate titles last mont" do
    assert_difference("Title.count") do
      get :generate_new_titles,:month=>Time.now.month.pred
    end
    assert_equal Time.now.month, contracts(:two).titles.last.due_date.month
  end

end
