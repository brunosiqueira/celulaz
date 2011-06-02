require 'test_helper'

class Company::RelationshipsControllerTest < ActionController::TestCase
  test "create already created" do
    login_as :empresa_valid
    assert !companies(:empresa_valid).destinies.include?(companies(:empresa))
    assert_difference("FeedItem.count", 1) do
      assert_difference("CompanyRelationship.count", 0) do
        post :friend_requests, :company_origin_id=>companies(:empresa), :status=>"true"
      end
    end
    assert_response :success
  end
  test "destroy already created" do
    login_as :empresa_valid
    assert !companies(:empresa_valid).destinies.include?(companies(:empresa))
    assert_difference("FeedItem.count", 0) do
      assert_difference("CompanyRelationship.count", -1) do
        post :friend_requests, :company_origin_id=>companies(:empresa), :status=>"false"
      end
    end
    assert_response :success
  end
end
