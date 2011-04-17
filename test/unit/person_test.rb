require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  fixtures :users, :people
  def test_can_confirm
    assert !people(:empresa).confirmed?
    assert !people(:empresa_first_confirm).confirmed?
    assert people(:admin_web).confirmed?
  end
  
  def test_relation_user_create
    assert_equal people(:empresa_first_confirm).user_create, users(:admin_web)
  end

end
