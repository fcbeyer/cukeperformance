require 'test_helper'

class TaskAlertsControllerTest < ActionController::TestCase
  setup do
    @task_alert_firefox = task_alerts(:three)
    @task_alert_ie = task_alerts(:four)
    @task_bvt = tasks(:three)
    @task_portalsmoke = tasks(:four)
  end

  test "should get index" do
    get :index, :task_id => @task_bvt.id.to_param
    assert_response :success
    assert_not_nil assigns(:task_alerts)
  end

  test "should get new" do
    get :new, :task_id => @task_bvt.id.to_param
    assert_response :success
  end

  test "should create task_alert" do
    assert_difference('TaskAlert.count') do
      post :create, task_alert: @task_alert_ie.attributes, :task_id => @task_portalsmoke.to_param
    end

    assert_redirected_to task_task_alert_path(@task_portalsmoke.id.to_param,assigns(:task_alert))
  end

  test "should show task_alert" do
    get :show, id: @task_alert_firefox.to_param, :task_id => @task_bvt.id.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_alert_firefox.to_param, :task_id => @task_bvt.id.to_param
    assert_response :success
  end

  test "should update task_alert" do
    put :update, :task_id => @task_portalsmoke.id.to_param, id: @task_alert_ie, task_alert: @task_alert_ie.attributes
    assert_redirected_to task_task_alert_path(@task_portalsmoke.id.to_param,assigns(:task_alert))
  end

  test "should destroy task_alert" do
    assert_difference('TaskAlert.count', -1) do
      delete :destroy, :task_id => @task_portalsmoke.id.to_param, id: @task_alert_ie.to_param
    end

    assert_redirected_to task_task_alerts_path
  end
end
