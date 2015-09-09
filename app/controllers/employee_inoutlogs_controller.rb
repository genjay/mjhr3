class EmployeeInoutlogsController < ApplicationController
  before_action :set_inoutlog, only: [:show, :edit, :update, :destroy]
  before_action :set_employee_name, only: [:index, :edit, :new]

  def index
    @employee_id = params[:employee_id]
    @inoutlogs = current_ou.view_employee_inoutlogs.where(employee_id: @employee_id).order("begin_at ASC")
  end

  def new
    employee = current_ou.employees.find_by(id:params[:employee_id])
    @inoutlog = current_ou.employee_inoutlogs.new
    @inoutlog.department_id = employee.department_id
  end

  def create
    form_date = Date.parse params[:employee_inoutlog][:begin_at] rescue nil
    case form_date
    when nil
      redirect_to new_employee_employee_inoutlog_path, :flash => { :alert => "操作錯誤，請檢查此員工狀態是否可異動或生效日期有誤" }
    else
      @inoutlog = current_ou.employee_inoutlogs.new(inoutlog_params)
      @inoutlog.employee_id = params[:employee_id]

      form_action = params[:employee_inoutlog][:action]
      form_depid = params[:employee_inoutlog][:department_id]
      act = action_permit(@inoutlog.employee_id, form_action, form_date)

      case act
      when false
          redirect_to new_employee_employee_inoutlog_path, :flash => { :alert => "操作錯誤，請檢查此員工狀態是否可異動或生效日期有誤" }
      when nil
          redirect_to new_employee_employee_inoutlog_path, :flash => { :alert => "異動類別錯誤" }
      else
        respond_to do |format|
          if @inoutlog.save
            update_employee(form_action, form_date, @inoutlog.employee_id, form_depid)
            format.html { redirect_to employee_employee_inoutlogs_path, notice: '人員異動設定新增成功' }
          else
            format.html { render :new }
          end
        end
      end
    end
  end

  def edit
    # @inoutlog.department_id = @inoutlog.department.id
  end

  # def update
  #   respond_to do |format|
  #     if @inoutlog.update(inoutlog_params)
  #       format.html { redirect_to employee_employee_inoutlogs_path, notice: '人員異動設定修改成功' }
  #     else
  #       format.html { render :edit }
  #     end
  #   end
  # end

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
    def action_permit(empid, act, date)
      opt_data = Option.find_by(key:act)

      if opt_data != nil    
        data = current_ou.employee_inoutlogs.check_permit(empid)
        case act
        when "A1"
          if data == nil
            true
          elsif data != nil and data.action == "Q1" and date >= data.begin_at
            true
          else
            false
          end
        else
          if data != nil and opt_data.status_rule.include? data.action and date >= data.begin_at
            true
          else
            false
          end
        end
      else
        nil
      end
    end

    def update_employee(action, date, emp_id, dep_id)
      case action
      when "A1"
        current_ou.employees.where(id:emp_id).update_all(arrive_date:date, leave_date:nil)
      when "Q1"
        current_ou.employees.where(id:emp_id).update_all(leave_date:date)
      when "C1"
        current_ou.employees.where(id:emp_id).update_all(department_id:dep_id)
      when "Q2"
        current_ou.employees.where(id:emp_id).update_all(leave_date:date)        
      when "A2"
        current_ou.employees.where(id:emp_id).update_all(leave_date:nil)        
      else
      end
    end

    def set_inoutlog
      @inoutlog = current_ou.employee_inoutlogs.find(params[:id])
    end

    def set_employee_name
      data = current_ou.employees.includes(:department).find_by(id: params[:employee_id])
      @employee_name = "#{data.name} #{data.department.name}"
    end

    def inoutlog_params
      params.require(:employee_inoutlog).permit(:employee_id, :action, :begin_at, :department_id, :days_of_jobage)
    end

end