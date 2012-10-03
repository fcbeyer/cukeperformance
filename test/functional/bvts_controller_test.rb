require 'test_helper'

class BvtsControllerTest < ActionController::TestCase
  setup do
    @bvt = bvts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bvts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bvt" do
    assert_difference('Bvt.count') do
      post :create, bvt: @bvt.attributes
    end

    assert_redirected_to bvt_path(assigns(:bvt))
  end

  test "should show bvt" do
    get :show, id: @bvt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bvt
    assert_response :success
  end

  test "should update bvt" do
    put :update, id: @bvt, bvt: @bvt.attributes
    assert_redirected_to bvt_path(assigns(:bvt))
  end

  test "should destroy bvt" do
    assert_difference('Bvt.count', -1) do
      delete :destroy, id: @bvt
    end

    assert_redirected_to bvts_path
  end
end
