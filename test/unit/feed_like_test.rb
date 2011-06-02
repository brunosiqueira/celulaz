require 'test_helper'

class FeedLikeTest < ActiveSupport::TestCase
  test "create like" do
    updated = feed_items(:empresa_valid).updated_at
    assert_difference("FeedLike.count", 1) do
      feed_items(:empresa_valid).feed_likes.create(:company=>companies(:empresa_valid_2))
    end
    feed_items(:empresa_valid).reload
    assert_equal 1, feed_items(:empresa_valid).feed_likes_count
    assert_not_equal updated, feed_items(:empresa_valid).updated_at
  end
end
