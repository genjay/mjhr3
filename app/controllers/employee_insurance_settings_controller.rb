class EmployeeInsuranceSettingsController < ApplicationController
  before_action :set_employee, only: [:edit, :update]
  before_action :set_subsidy_type, only: [:edit]

  def edit
  end

  def update
    respond_to do |format|
      if @employee_insurance.update(employee_insurance_params)
        format.html { redirect_to edit_employee_path(@employee), notice: '員工勞健保修改成功' }
      else
        format.html { render :edit }
      end
    end
  end

  private 
    def set_employee
      @employee = current_ou.employees.find(params[:employee_id])
      # has_one 無 @emplyee.employee_insurane_setting.new 可用所以用下列方式  
      @employee_insurance = EmployeeInsuranceSetting.find_or_initialize_by(employee_id: @employee.id)
    end

    def set_subsidy_type
      @subsidy_type = current_ou.subsidies.all
      @lvlist_A = current_ou.lvtypes.find_by(uid:'A').lvlists.order(:amt) 
      @lvlist_B = current_ou.lvtypes.find_by(uid:'B').lvlists.order(:amt)  
      @lvlist_C = current_ou.lvtypes.find_by(uid:'C').lvlists.order(:amt)  
    end

    def employee_insurance_params
      params.require(:employee_insurance_setting).permit(:employee_id, :NHI_LV, :NHI_begin_at, :NHI_end_at, :NHI_subsidy_id, :labor_lv, :labor_begin_at, :labor_end_at, :labor_subsidy_id,  :LP_Lv, :LP_begin_at, :LP_end_at, :LP_subsidy_id, :is_free_for_2nd, :reson_for_free2nd, :memo)
    end

end