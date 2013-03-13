require 'test_helper'

class RunTimeNotifierTest < ActionMailer::TestCase
  test "bvt" do
    mail = RunTimeNotifier.bvt
    assert_equal "Bvt", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "portalsmoke" do
    mail = RunTimeNotifier.portalsmoke
    assert_equal "Portalsmoke", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
