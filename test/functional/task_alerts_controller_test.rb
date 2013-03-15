require 'test_helper'

class TaskAlertsControllerTest < ActionController::TestCase
  setup do
    @task_alert = task_alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_alerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_alert" do
    assert_difference('TaskAlert.count') do
      post :create, task_alert: @task_alert.attributes
    end

    assert_redirected_to task_alert_path(assigns(:task_alert))
  end

  test "should show task_alert" do
    get :show, id: @task_alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_alert
    assert_response :success
  end

  test "should update task_alert" do
    put :update, id: @task_alert, task_alert: @task_alert.attributes
    assert_redirected_to task_alert_path(assigns(:task_alert))
  end

  test "should destroy task_alert" do
    assert_difference('TaskAlert.count', -1) do
      delete :destroy, id: @task_alert
    end

    assert_redirected_to task_alerts_path
  end
end
