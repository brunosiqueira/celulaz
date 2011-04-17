require 'test_helper'

class TitleMailerTest < ActionMailer::TestCase
  test "accepted" do
    @expected.subject = 'TitleMailer#accepted'
    @expected.body    = read_fixture('accepted')
    @expected.date    = Time.now

    assert_match /você possui pagamentos pendentes no site/, TitleMailer.create_accepted(titles(:six)).encoded
  end

end
