require 'test_helper'

class CatcodesControllerTest < ActionController::TestCase
  setup do
    @catcode = catcodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catcodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catcode" do
    assert_difference('Catcode.count') do
      post :create, catcode: { col_name: @catcode.col_name, is_stoped: @catcode.is_stoped, m_name: @catcode.m_name, memo: @catcode.memo, name: @catcode.name, ou_id: @catcode.ou_id, uid: @catcode.uid }
    end

    assert_redirected_to catcode_path(assigns(:catcode))
  end

  test "should show catcode" do
    get :show, id: @catcode
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catcode
    assert_response :success
  end

  test "should update catcode" do
    patch :update, id: @catcode, catcode: { col_name: @catcode.col_name, is_stoped: @catcode.is_stoped, m_name: @catcode.m_name, memo: @catcode.memo, name: @catcode.name, ou_id: @catcode.ou_id, uid: @catcode.uid }
    assert_redirected_to catcode_path(assigns(:catcode))
  end

  test "should destroy catcode" do
    assert_difference('Catcode.count', -1) do
      delete :destroy, id: @catcode
    end

    assert_redirected_to catcodes_path
  end
end
