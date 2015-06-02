require 'test_helper'

class PayTypesControllerTest < ActionController::TestCase
  setup do
    @pay_type = pay_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pay_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pay_type" do
    assert_difference('PayType.count') do
      post :create, pay_type: { cycle_unit: @pay_type.cycle_unit, is_stoped: @pay_type.is_stoped, memo: @pay_type.memo, name: @pay_type.name, ou_it: @pay_type.ou_it, rule_for_break: @pay_type.rule_for_break, uid: @pay_type.uid }
    end

    assert_redirected_to pay_type_path(assigns(:pay_type))
  end

  test "should show pay_type" do
    get :show, id: @pay_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pay_type
    assert_response :success
  end

  test "should update pay_type" do
    patch :update, id: @pay_type, pay_type: { cycle_unit: @pay_type.cycle_unit, is_stoped: @pay_type.is_stoped, memo: @pay_type.memo, name: @pay_type.name, ou_it: @pay_type.ou_it, rule_for_break: @pay_type.rule_for_break, uid: @pay_type.uid }
    assert_redirected_to pay_type_path(assigns(:pay_type))
  end

  test "should destroy pay_type" do
    assert_difference('PayType.count', -1) do
      delete :destroy, id: @pay_type
    end

    assert_redirected_to pay_types_path
  end
end
