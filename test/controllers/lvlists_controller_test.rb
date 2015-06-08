require 'test_helper'

class LvlistsControllerTest < ActionController::TestCase
  setup do
    @lvlist = lvlists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lvlists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lvlist" do
    assert_difference('Lvlist.count') do
      post :create, lvlist: { amt: @lvlist.amt, ou_id: @lvlist.ou_id, uid: @lvlist.uid }
    end

    assert_redirected_to lvlist_path(assigns(:lvlist))
  end

  test "should show lvlist" do
    get :show, id: @lvlist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lvlist
    assert_response :success
  end

  test "should update lvlist" do
    patch :update, id: @lvlist, lvlist: { amt: @lvlist.amt, ou_id: @lvlist.ou_id, uid: @lvlist.uid }
    assert_redirected_to lvlist_path(assigns(:lvlist))
  end

  test "should destroy lvlist" do
    assert_difference('Lvlist.count', -1) do
      delete :destroy, id: @lvlist
    end

    assert_redirected_to lvlists_path
  end
end
