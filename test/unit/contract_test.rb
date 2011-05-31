require 'test_helper'

class ContractTest < ActiveSupport::TestCase
  test "should find one with no title" do
    assert_equal 1, Contract.find_all_and_no_title(Time.now.month).size
  end
end
