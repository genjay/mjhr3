class EmployeeInoutlogsController < ApplicationController
  before_action :set_inoutlog, only: [:show, :edit, :update, :destroy]
  before_action :set_employee, only: [:index, :edit, :new]

  def index
    @inoutlogs = @employee.view_employee_inoutlogs.order(begin_at: :asc,id: :asc)
  end

  def new
    @inoutlog = @employee.employee_inoutlogs.new
    @inoutlog.department_id = @employee.department_id
  end

  def create
    render :text => params
    return
    emp = current_ou.employees.find(params[:employee_id])
    @inoutlog = emp.employee_inoutlogs.new(inoutlog_params)
    if @inoutlog.save
      redirect_to employee_employee_inoutlogs_path, notice: '人員異動設定修改成功' 
    else
      render :new
    end
  end #create

  def edit
  end

  def multi_destroy
    items = params[:ids]
    case items
    when nil
      redirect_to employee_employee_inoutlogs_path, :flash => { :alert => "沒有項目被選取" }      
    else
      if items.size == 1
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
      else
        redirect_to employee_employee_inoutlogs_path, :flash => { :alert => "同一時間只能刪除一個項目" }
      end
    end
  end

  private
    def set_inoutlog
      @inoutlog = current_ou.employee_inoutlogs.find(params[:id])
    end

    def set_employee
      @employee = current_ou.employees.find params[:employee_id]
    end

    def inoutlog_params
      params.require(:employee_inoutlog).permit(:employee_id, :action, :begin_at, :department_id, :days_of_jobage)
    end

end