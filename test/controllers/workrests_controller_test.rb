require 'test_helper'

class WorkrestsControllerTest < ActionController::TestCase
  setup do
    @workrest = workrests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workrests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workrest" do
    assert_difference('Workrest.count') do
      post :create, workrest: {  }
    end

    assert_redirected_to workrest_path(assigns(:workrest))
  end

  test "should show workrest" do
    get :show, id: @workrest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workrest
    assert_response :success
  end

  test "should update workrest" do
    patch :update, id: @workrest, workrest: {  }
    assert_redirected_to workrest_path(assigns(:workrest))
  end

  test "should destroy workrest" do
    assert_difference('Workrest.count', -1) do
      delete :destroy, id: @workrest
    end

    assert_redirected_to workrests_path
  end
end
