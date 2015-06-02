require 'test_helper'

class OfftypesControllerTest < ActionController::TestCase
  setup do
    @offtype = offtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offtype" do
    assert_difference('Offtype.count') do
      post :create, offtype: { can_duplicate: @offtype.can_duplicate, deduct_percent: @offtype.deduct_percent, include_holiday: @offtype.include_holiday, is_quota_ctrl: @offtype.is_quota_ctrl, is_stoped: @offtype.is_stoped, memo: @offtype.memo, mins_of_minimum: @offtype.mins_of_minimum, mins_per_unit: @offtype.mins_per_unit, name: @offtype.name, ou_id: @offtype.ou_id, uid: @offtype.uid }
    end

    assert_redirected_to offtype_path(assigns(:offtype))
  end

  test "should show offtype" do
    get :show, id: @offtype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offtype
    assert_response :success
  end

  test "should update offtype" do
    patch :update, id: @offtype, offtype: { can_duplicate: @offtype.can_duplicate, deduct_percent: @offtype.deduct_percent, include_holiday: @offtype.include_holiday, is_quota_ctrl: @offtype.is_quota_ctrl, is_stoped: @offtype.is_stoped, memo: @offtype.memo, mins_of_minimum: @offtype.mins_of_minimum, mins_per_unit: @offtype.mins_per_unit, name: @offtype.name, ou_id: @offtype.ou_id, uid: @offtype.uid }
    assert_redirected_to offtype_path(assigns(:offtype))
  end

  test "should destroy offtype" do
    assert_difference('Offtype.count', -1) do
      delete :destroy, id: @offtype
    end

    assert_redirected_to offtypes_path
  end
end
