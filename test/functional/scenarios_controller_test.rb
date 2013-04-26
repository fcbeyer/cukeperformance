require 'test_helper'

class ScenariosControllerTest < ActionController::TestCase
  setup do
    @scenario = scenarios(:one)
    @scenario_bvt = scenarios(:three)
    @scenario_portalsmoke = scenarios(:four)
    @feature_bvt = features(:three)
    @feature_portalsmoke = features(:four)
    @bvt = suites(:bvt)
    @portalsmoke = suites(:portalsmoke)
  end

  test "should get index" do
    get :index, :suite_id => @bvt.id.to_param, :feature_id => @feature_bvt.id.to_param
    assert_response :success
    assert_not_nil assigns(:scenarios)
  end

  test "should get new" do
    get :new, :suite_id => @bvt.id.to_param, :feature_id => @feature_bvt.id.to_param
    assert_response :success
  end

  test "should create scenario" do
    assert_difference('Scenario.count') do
      post :create, scenario: @scenario_portalsmoke.attributes, :suite_id => @portalsmoke.to_param, :feature_id => @feature_portalsmoke.to_param
    end

    assert_redirected_to suite_feature_scenario_path(@portalsmoke.id.to_param, @feature_portalsmoke.id.to_param, assigns(:scenario))
  end

  test "should show scenario" do
    get :show, id: @scenario_bvt.to_param, :suite_id => @bvt.id.to_param, :feature_id => @feature_bvt.id.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scenario_bvt.to_param, :suite_id => @bvt.id.to_param, :feature_id => @feature_bvt.id.to_param
    assert_response :success
  end

  test "should update scenario" do
    put :update, :suite_id => @portalsmoke.to_param, :feature_id => @feature_portalsmoke.to_param, id: @scenario_portalsmoke, scenario: @scenario_portalsmoke.attributes
    assert_redirected_to suite_feature_scenario_path(@portalsmoke.id.to_param, @feature_portalsmoke.id.to_param, assigns(:scenario))
  end

  test "should destroy scenario" do
    assert_difference('Scenario.count', -1) do
      delete :destroy, :suite_id => @portalsmoke.id.to_param, :feature_id => @feature_portalsmoke.id.to_param, id: @scenario_portalsmoke.to_param
    end

    assert_redirected_to suite_feature_scenarios_path
  end
end
