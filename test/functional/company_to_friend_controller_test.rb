require 'test_helper'

class CompanyToFriendControllerTest < ActionController::TestCase
  def test_create
    assert_equal 0, layouts(:empresa_valid).send_to_friend
    get :create,
        { :name_from => "Bruno Siqueira", :email_from => "bruno_sil@yahoo.com.br",
          :email_to => "bsiqueira@gmail.com", :company_id => companies(:empresa_valid).id }
    assert_response :success
    layouts(:empresa_valid).reload
    assert_equal 1, layouts(:empresa_valid).send_to_friend, "Não incrementou o numero de email enviados"
  end
  
#TODO descomentar quando fizer a validação server side
#  def test_create_email_invalid
#    assert_equal 0, layouts(:empresa_valid).send_to_friend
#    get :create,{ :email_to=>"XXXXXXXXX",:company_id => companies(:empresa_valid).id}
#    assert_response :success
#    layouts(:empresa_valid).reload
#    assert_equal 0, layouts(:empresa_valid).send_to_friend
#  end
end
