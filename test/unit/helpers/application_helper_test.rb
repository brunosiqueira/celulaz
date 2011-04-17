# To change this template, choose Tools | Templates
# and open the template in the editor.

class ApplicationHelperTest < ActionView::TestCase
  test "convert url parameter" do
    assert_equal ["X0Pb_ZZdcq8"],recover_url_image_code("http://www.youtube.com/watch?v=X0Pb_ZZdcq8&feature=aso")
  end

  test "convert url path" do
    assert_equal "Cy4ufGtg9hU",recover_url_image_code("http://www.youtube.com/v/Cy4ufGtg9hU")
  end
end
