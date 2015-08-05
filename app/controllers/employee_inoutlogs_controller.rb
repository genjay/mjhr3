class EmployeeInoutlogsController < ApplicationController
  before_action :set_inoutlog, only: [:show, :edit, :update, :destroy]
  before_action :set_employee_name, only: [:index, :edit, :new]

  def index
    @employee_id = params[:employee_id]
    @inoutlogs = current_ou.employee_inoutlogs.includes(:employee).where(:employee_id => @employee_id)
  end

  def new
    @inoutlog = current_ou.employee_inoutlogs.new
  end

  def create
    @inoutlog = current_ou.employee_inoutlogs.new(inoutlog_params)
    @inoutlog.employee_id = params[:employee_id]
    respond_to do |format|
      if @inoutlog.save
        format.html { redirect_to employee_employee_inoutlogs_path, notice: '人員異動設定新增成功' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @inoutlog.update(inoutlog_params)
        format.html { redirect_to employee_employee_inoutlogs_path, notice: '人員異動設定修改成功' }
      else
        format.html { render :edit }
      end
    end
  end

  def multi_destroy 
    err_msg,ok_msg,all_msg = '','',''
    params[:ids].each do |f|
      x = current_ou.employee_inoutlogs.find(f)
      if x.destroy
        ok_msg = ok_msg << "[#{x.employee.name} #{x.action}]"
      else
        err_msg = err_msg << "[#{x.employee.name} #{x.action}] 刪除失敗 " << x.errors[:base].join << '\n'
      end
    end

      all_msg = (ok_msg.size==0? '' :(ok_msg << "刪除完成\\n")) << err_msg
      respond_to do |format|
        if err_msg.size>0
          format.html { redirect_to employee_employee_inoutlogs_path, alert: all_msg }
        else
          format.html { redirect_to employee_employee_inoutlogs_path, notice: all_msg }
        end
      end
  end

  private
    def set_inoutlog
      @inoutlog = current_ou.employee_inoutlogs.find(params[:id])
    end

    def set_employee_name
      @employee_name = Employee.find_by(id: params[:employee_id]).name
    end

    def inoutlog_params
      params.require(:employee_inoutlog).permit(:employee_id, :action, :begin_at, :department_id, :days_of_jobage)
    end

end