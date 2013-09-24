require 'test_helper'

class PowerpointsControllerTest < ActionController::TestCase
  setup do
    @powerpoint = powerpoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:powerpoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create powerpoint" do
    assert_difference('Powerpoint.count') do
      post :create, powerpoint: { description: @powerpoint.description, title: @powerpoint.title, user_id: @powerpoint.user_id }
    end

    assert_redirected_to powerpoint_path(assigns(:powerpoint))
  end

  test "should show powerpoint" do
    get :show, id: @powerpoint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @powerpoint
    assert_response :success
  end

  test "should update powerpoint" do
    patch :update, id: @powerpoint, powerpoint: { description: @powerpoint.description, title: @powerpoint.title, user_id: @powerpoint.user_id }
    assert_redirected_to powerpoint_path(assigns(:powerpoint))
  end

  test "should destroy powerpoint" do
    assert_difference('Powerpoint.count', -1) do
      delete :destroy, id: @powerpoint
    end

    assert_redirected_to powerpoints_path
  end
end
