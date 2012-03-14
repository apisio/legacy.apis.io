require 'test_helper'

class MentionMailerTest < ActionMailer::TestCase
  test "alerter" do
    mail = MentionMailer.alerter
    assert_equal "Alerter", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
