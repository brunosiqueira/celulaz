require 'test_helper'

class Financial::ShippingTitleTest < ActiveSupport::TestCase
  test "should create with status selecionado" do
    st = ShippingTitle.create :shipping=>shippings(:with_titles), :title=>titles(:one)
    assert_equal "Selecionado", st.status
  end

  test "should destroy with status digitado" do
    st = ShippingTitle.create :shipping=>shippings(:with_titles), :title=>titles(:one)
    assert_equal "Selecionado", st.status
    assert_equal "Selecionado", titles(:one).status

    ShippingTitle.destroy(st.id)
    titles(:one).reload
    assert_equal "Digitado", titles(:one).status
  end

end
