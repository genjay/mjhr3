require 'test_helper'

class InsuranceSettingsControllerTest < ActionController::TestCase
  setup do
    @insurance_setting = insurance_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insurance_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insurance_setting" do
    assert_difference('InsuranceSetting.count') do
      post :create, insurance_setting: { a_compayny: @insurance_setting.a_compayny, a_employee: @insurance_setting.a_employee, a_rate: @insurance_setting.a_rate, b_compayny: @insurance_setting.b_compayny, b_employee: @insurance_setting.b_employee, b_rate: @insurance_setting.b_rate, c_compayny: @insurance_setting.c_compayny, c_employee: @insurance_setting.c_employee, c_rate: @insurance_setting.c_rate, d_compayny: @insurance_setting.d_compayny, d_employee: @insurance_setting.d_employee, d_rate: @insurance_setting.d_rate, e_compayny: @insurance_setting.e_compayny, e_employee: @insurance_setting.e_employee, e_rate: @insurance_setting.e_rate, is_stoped: @insurance_setting.is_stoped, memo: @insurance_setting.memo, name: @insurance_setting.name, ou_id: @insurance_setting.ou_id, uid: @insurance_setting.uid }
    end

    assert_redirected_to insurance_setting_path(assigns(:insurance_setting))
  end

  test "should show insurance_setting" do
    get :show, id: @insurance_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @insurance_setting
    assert_response :success
  end

  test "should update insurance_setting" do
    patch :update, id: @insurance_setting, insurance_setting: { a_compayny: @insurance_setting.a_compayny, a_employee: @insurance_setting.a_employee, a_rate: @insurance_setting.a_rate, b_compayny: @insurance_setting.b_compayny, b_employee: @insurance_setting.b_employee, b_rate: @insurance_setting.b_rate, c_compayny: @insurance_setting.c_compayny, c_employee: @insurance_setting.c_employee, c_rate: @insurance_setting.c_rate, d_compayny: @insurance_setting.d_compayny, d_employee: @insurance_setting.d_employee, d_rate: @insurance_setting.d_rate, e_compayny: @insurance_setting.e_compayny, e_employee: @insurance_setting.e_employee, e_rate: @insurance_setting.e_rate, is_stoped: @insurance_setting.is_stoped, memo: @insurance_setting.memo, name: @insurance_setting.name, ou_id: @insurance_setting.ou_id, uid: @insurance_setting.uid }
    assert_redirected_to insurance_setting_path(assigns(:insurance_setting))
  end

  test "should destroy insurance_setting" do
    assert_difference('InsuranceSetting.count', -1) do
      delete :destroy, id: @insurance_setting
    end

    assert_redirected_to insurance_settings_path
  end
end
