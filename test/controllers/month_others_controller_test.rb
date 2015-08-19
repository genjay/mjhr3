require 'test_helper'

class MonthOthersControllerTest < ActionController::TestCase
  setup do
    @month_other = month_others(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:month_others)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create month_other" do
    assert_difference('MonthOther.count') do
      post :create, month_other: { amt: @month_other.amt, employee_id: @month_other.employee_id, ou_id: @month_other.ou_id, pay_type_id: @month_other.pay_type_id, yyyymm: @month_other.yyyymm }
    end

    assert_redirected_to month_other_path(assigns(:month_other))
  end

  test "should show month_other" do
    get :show, id: @month_other
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @month_other
    assert_response :success
  end

  test "should update month_other" do
    patch :update, id: @month_other, month_other: { amt: @month_other.amt, employee_id: @month_other.employee_id, ou_id: @month_other.ou_id, pay_type_id: @month_other.pay_type_id, yyyymm: @month_other.yyyymm }
    assert_redirected_to month_other_path(assigns(:month_other))
  end

  test "should destroy month_other" do
    assert_difference('MonthOther.count', -1) do
      delete :destroy, id: @month_other
    end

    assert_redirected_to month_others_path
  end
end
