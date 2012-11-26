require 'test_helper'

class GraphControllerTest < ActionController::TestCase
  test "should get suites" do
    get :suites
    assert_response :success
  end

  test "should get features" do
    get :features
    assert_response :success
  end

  test "should get scenarios" do
    get :scenarios
    assert_response :success
  end

  test "should get steps" do
    get :steps
    assert_response :success
  end

end
