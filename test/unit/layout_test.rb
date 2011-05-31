require 'test_helper'

class LayoutTest < ActiveSupport::TestCase
#  def test_ferret_search
#    layouts = Layout.find_by_contents("Empresa")
#    assert_equal 2,layouts.size
#  end

  def test_increment
    assert_equal 0, layouts(:empresa_valid).send_to_friend
    assert layouts(:empresa_valid).increment_send_to_friend!
    layouts(:empresa_valid).reload
    assert_equal 1, layouts(:empresa_valid).send_to_friend
  end

  def test_tabs_with_components
    assert_equal 1 , layouts(:empresa_valid).tabs_with_components.size
    assert_equal 1 , layouts(:empresa_valid_2).tabs_with_components.size
  end

  def test_tabs
    assert_equal 2 , layouts(:empresa_valid).tabs.size
  end
end
