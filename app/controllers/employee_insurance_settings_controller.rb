class EmployeeInsuranceSettingsController < ApplicationController
  before_action :set_employee_insurance, only: [:show, :edit, :update, :destroy]
  before_action :set_employee_name, only: [:index, :edit, :new]

  def index
    @employee_id = params[:employee_id]
    @employee_insurances = current_ou.employee_insurance_settings.includes(:employee).where(:employee_id => @employee_id)
  end

  def new
    if current_ou.employee_insurance_settings.where(:employee_id => params[:employee_id]).size == 0
      @employee_insurance = current_ou.employee_insurance_settings.new
    else
      redirect_to employee_employee_insurance_settings_path, alert: '此員工已經有一筆資料'
    end
  end

  def create
    @employee_insurance = current_ou.employee_insurance_settings.new(employee_insurance_params)
    @employee_insurance.employee_id = params[:employee_id]
    respond_to do |format|
      if @employee_insurance.save
        format.html { redirect_to employee_employee_insurance_settings_path, notice: '員工勞健保新增成功' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @employee_insurance.update(employee_insurance_params)
        format.html { redirect_to employee_employee_insurance_settings_path, notice: '員工勞健保修改成功' }
      else
        format.html { render :edit }
      end
    end
  end

  def multi_destroy 
    err_msg,ok_msg,all_msg = '','',''
    params[:ids].each do |f|
      x = current_ou.employee_insurance_settings.find(f)
      if x.destroy
        ok_msg = ok_msg << "[#{x.employee.name} #{x.NHI_LV}]"
      else
        err_msg = err_msg << "[#{x.employee.name} #{x.NHI_LV}] 刪除失敗 " << x.errors[:base].join << '\n'
      end
    end

      all_msg = (ok_msg.size==0? '' :(ok_msg << "刪除完成\\n")) << err_msg
      respond_to do |format|
        if err_msg.size>0
          format.html { redirect_to employee_employee_insurance_settings_path, alert: all_msg }
        else
          format.html { redirect_to employee_employee_insurance_settings_path, notice: all_msg }
        end
      end
  end

  private
    def set_employee_insurance
      @employee_insurance = current_ou.employee_insurance_settings.find(params[:id])
    end

    def set_employee_name
      @employee_name = current_ou.employees.find_by(id: params[:employee_id]).name
    end

    def employee_insurance_params
      params.require(:employee_insurance_setting).permit(:employee_id, :NHI_LV, :NHI_begin_at, :NHI_end_at, :NHI_subsidy_id, :labor_lv, :labor_begin_at, :labor_end_at, :labor_subsidy_id,  :LP_Lv, :LP_begin_at, :LP_end_at, :LP_subsidy_id, :is_free_for_2nd, :reson_for_free2nd, :memo)
    end

end