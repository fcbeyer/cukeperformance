require 'test_helper'

class FeaturesControllerTest < ActionController::TestCase
  setup do
    @feature = features(:one)
    @feature_bvt = features(:three)
    @feature_portalsmoke = features(:four)
    @bvt = suites(:bvt)
    @portalsmoke = suites(:portalsmoke)
  end

  test "should get index" do
    get :index, :suite_id => @bvt.id.to_param
    assert_response :success
    assert_not_nil assigns(:features)
  end

  test "should get new" do
    get :new, :suite_id => @bvt.id.to_param
    assert_response :success
  end

  test "should create feature" do
    assert_difference('Feature.count') do
      post :create, feature: @feature_portalsmoke.attributes, :suite_id => @portalsmoke.to_param
    end

    assert_redirected_to suite_feature_path(@portalsmoke.id.to_param,assigns(:feature))
  end

  test "should show feature" do
    get :show, id: @feature_bvt.to_param, :suite_id => @bvt.id.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feature_bvt.to_param, :suite_id => @bvt.id.to_param
    assert_response :success
  end

  test "should update feature" do
    put :update, :suite_id => @portalsmoke.id.to_param, id: @feature_portalsmoke, feature: @feature_portalsmoke.attributes
    assert_redirected_to suite_feature_path(@portalsmoke.id.to_param,assigns(:feature))
  end

  test "should destroy feature" do
    assert_difference('Feature.count', -1) do
      delete :destroy, :suite_id => @portalsmoke.id.to_param, id: @feature_portalsmoke.to_param
    end

    assert_redirected_to suite_features_path
  end
end
