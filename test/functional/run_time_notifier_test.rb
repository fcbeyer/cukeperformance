require 'test_helper'

class RunTimeNotifierTest < ActionMailer::TestCase
  test "bvt" do
    mail = RunTimeNotifier.bvt
    assert_equal "Cuke Performance BVT Alert", mail.subject
    assert_equal ["rbeyer@patientkeeper.com"], mail.to
    assert_equal ["cukes@patientkeeper.com"], mail.from
    assert_match "Hi", "/Hi/"
  end

  test "portalsmoke" do
    mail = RunTimeNotifier.portalsmoke
    assert_equal "Cuke Performance Portal Smoke Alert", mail.subject
    assert_equal ["teamverve@patientkeeper.com"], mail.to
    assert_equal ["cukes@patientkeeper.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
