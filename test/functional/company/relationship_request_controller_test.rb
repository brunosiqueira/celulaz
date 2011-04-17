require 'test_helper'

class Company::RelationshipRequestControllerTest < ActionController::TestCase
  def test_create
    login_as :empresa_valid
    assert !companies(:empresa_valid).destinies.include?(companies(:empresa_first_confirm))
    assert_difference("FeedItem.count", 0) do
      assert_difference("CompanyRelationship.count", 1) do
        put :create, {:id=>companies(:empresa_first_confirm).id}
      end
    end
    companies(:empresa_valid).reload
    assert_equal 'Relacionamento iniciado. Aguarde confirmação',flash[:notice]
    assert_equal companies(:empresa_first_confirm) , companies(:empresa_valid).destinies.first
    assert_response :success
  end

  def test_create_already_created
    login_as :empresa_valid
    assert !companies(:empresa_valid).destinies.include?(companies(:empresa))
    assert_difference("FeedItem.count", 0) do
      assert_difference("CompanyRelationship.count", 0) do
        put :create, {:id=>companies(:empresa).id}
      end
    end
    assert companies(:empresa_valid).origins.include? companies(:empresa)
    assert_redirected_to :action=>:update
  end

  def test_create_self_relationship
    login_as :empresa_valid
    put :create, {:id=>companies(:empresa_valid).id}
    assert_equal I18n.t("company.messages.relationship_unable"),flash[:error]
    assert_response :success
  end

  def test_update
    login_as :empresa_valid

    put :update, {:id=>companies(:empresa).id}

    assert_equal 'Relacionamento criado com sucesso.', flash[:notice]
    assert companies(:empresa_valid).friends.include? companies(:empresa)

    assert_response :success
  end

  def test_destroy
    login_as :empresa_valid

    put :destroy, {:id=>companies(:empresa).id}

    assert_equal 'Relacionamento cancelado.', flash[:notice]
    companies(:empresa_valid).origins.reload
    assert !companies(:empresa_valid).origins.include?(companies(:empresa))

    assert_redirected_to :controller=>"company/profile", :action => "public"
  end

end
