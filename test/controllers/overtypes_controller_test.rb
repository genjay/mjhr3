require 'test_helper'

class OvertypesControllerTest < ActionController::TestCase
  setup do
    @overtype = overtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:overtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create overtype" do
    assert_difference('Overtype.count') do
      post :create, overtype: { amt_of_A: @overtype.amt_of_A, amt_of_B: @overtype.amt_of_B, amt_of_C: @overtype.amt_of_C, amt_of_H: @overtype.amt_of_H, is_stoped: @overtype.is_stoped, memo: @overtype.memo, mins_of_A: @overtype.mins_of_A, mins_of_B: @overtype.mins_of_B, mins_per_unit: @overtype.mins_per_unit, name: @overtype.name, ou_id: @overtype.ou_id, pay_type: @overtype.pay_type, rate_of_A: @overtype.rate_of_A, rate_of_B: @overtype.rate_of_B, rate_of_C: @overtype.rate_of_C, rate_of_H: @overtype.rate_of_H, uid: @overtype.uid, valid_unit: @overtype.valid_unit }
    end

    assert_redirected_to overtype_path(assigns(:overtype))
  end

  test "should show overtype" do
    get :show, id: @overtype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @overtype
    assert_response :success
  end

  test "should update overtype" do
    patch :update, id: @overtype, overtype: { amt_of_A: @overtype.amt_of_A, amt_of_B: @overtype.amt_of_B, amt_of_C: @overtype.amt_of_C, amt_of_H: @overtype.amt_of_H, is_stoped: @overtype.is_stoped, memo: @overtype.memo, mins_of_A: @overtype.mins_of_A, mins_of_B: @overtype.mins_of_B, mins_per_unit: @overtype.mins_per_unit, name: @overtype.name, ou_id: @overtype.ou_id, pay_type: @overtype.pay_type, rate_of_A: @overtype.rate_of_A, rate_of_B: @overtype.rate_of_B, rate_of_C: @overtype.rate_of_C, rate_of_H: @overtype.rate_of_H, uid: @overtype.uid, valid_unit: @overtype.valid_unit }
    assert_redirected_to overtype_path(assigns(:overtype))
  end

  test "should destroy overtype" do
    assert_difference('Overtype.count', -1) do
      delete :destroy, id: @overtype
    end

    assert_redirected_to overtypes_path
  end
end
