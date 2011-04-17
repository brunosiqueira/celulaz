require 'test_helper'
require 'app/util/shipping_file'

class Financial::ShippingTest < ActiveSupport::TestCase
  test "should create shipping file with 400 characters" do
    file = ShippingFile::create_file shippings(:with_titles)
    file.rewind

    file.each_line{ |line|
      assert_equal 400,line.chomp.length
    }
  end

  test "should be opened" do
    assert shippings(:with_titles).open?
  end

#  test "should verify valid return value" do
#    file = File.open "test/resources/ATK.ECLABAZM.TOU.BRMB.R00OXQU.RTCOB.G0001V00.CNAB240.RET_BA.OK"
#    assert Shipping.valid_return_file?(file)
#  end
end
