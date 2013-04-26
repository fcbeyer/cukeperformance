require 'test_helper'

class StepsControllerTest < ActionController::TestCase
  setup do
    @step = steps(:one)
    @step_bvt = steps(:three)
    @step_portalsmoke = steps(:four)
    @scenario_bvt = scenarios(:three)
    @scenario_portalsmoke = scenarios(:four)
    @feature_bvt = features(:three)
    @feature_portalsmoke = features(:four)
    @bvt = suites(:bvt)
    @portalsmoke = suites(:portalsmoke)
  end

  test "should get index" do
    get :index, :suite_id => @bvt.id.to_param, :feature_id => @feature_bvt.id.to_param, :scenario_id => @scenario_bvt
    assert_response :success
    assert_not_nil assigns(:steps)
  end

  test "should get new" do
    get :new, :suite_id => @bvt.id.to_param, :feature_id => @feature_bvt.id.to_param, :scenario_id => @scenario_bvt
    assert_response :success
  end

  test "should create step" do
    assert_difference('Step.count') do
      post :create, step: @step_portalsmoke.attributes, :suite_id => @portalsmoke.to_param, :feature_id => @feature_portalsmoke.to_param, :scenario_id => @scenario_portalsmoke.to_param
    end

    assert_redirected_to suite_feature_scenario_step_path(@portalsmoke.id.to_param, @feature_portalsmoke.id.to_param, @scenario_portalsmoke.id.to_param, assigns(:step))
  end

  test "should show step" do
    get :show, id: @step.to_param, :suite_id => @bvt.id.to_param, :feature_id => @feature_bvt.id.to_param, :scenario_id => @scenario_bvt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @step.to_param, :suite_id => @bvt.id.to_param, :feature_id => @feature_bvt.id.to_param, :scenario_id => @scenario_bvt
    assert_response :success
  end

  test "should update step" do
    put :update, :suite_id => @portalsmoke.to_param, :feature_id => @feature_portalsmoke.to_param, :scenario_id => @scenario_portalsmoke.to_param, id: @step_portalsmoke, step: @step_portalsmoke.attributes
    assert_redirected_to suite_feature_scenario_step_path(@portalsmoke.id.to_param, @feature_portalsmoke.id.to_param, @scenario_portalsmoke.id.to_param, assigns(:step))
  end

  test "should destroy step" do
    assert_difference('Step.count', -1) do
      delete :destroy, :suite_id => @portalsmoke.id.to_param, :feature_id => @feature_portalsmoke.id.to_param, :scenario_id => @scenario_portalsmoke.id.to_param, id: @step_portalsmoke
    end

    assert_redirected_to suite_feature_scenario_steps_path
  end
end
