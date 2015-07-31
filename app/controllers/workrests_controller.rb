class WorkrestsController < ApplicationController
    before_action :set_workrest, only: [:show, :edit, :update, :destroy]

  def index
    # @workrests = current_ou.workrests.includes(:worktype).order(id: :asc)
    @workrests = current_ou.workrests.where(:worktype_id => params[:worktype_id])
  end

  def show
  end

  def new
    worktype = current_ou.worktypes.find(params[:worktype_id])
    @work_name = worktype[:name]
    @workrest = current_ou.workrests.new
  end

  def edit
  end

  def create
    @workrest = current_ou.workrests.new(workrest_params)

    respond_to do |format|
      if @workrest.save
        format.html { redirect_to worktype_workrests_path, notice: 'Workrest was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @workrest.update(workrest_params)
        format.html { redirect_to worktype_workrests_path, notice: 'Workrest was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def multi_destroy 
    err_msg,ok_msg,all_msg = '','',''
    params[:ids].each do |f|
      x = current_ou.workrests.find(f)
      if x.destroy
        ok_msg = ok_msg << "[#{x.mins_of_rest}]"
      else
        err_msg = err_msg << "[#{x.mins_of_rest}] 刪除失敗 " << x.errors[:base].join << '\n'
      end
    end

      all_msg = (ok_msg.size==0? '' :(ok_msg << "刪除完成\\n")) << err_msg
      respond_to do |format|
        if err_msg.size>0
          format.html { redirect_to worktype_workrests_path, alert: all_msg }
        else
          format.html { redirect_to worktype_workrests_path, notice: all_msg }
        end
      end
  end

  private
    def set_workrest
      @workrest = current_ou.workrests.find(params[:id])
    end

    def workrest_params
      params.require(:workrest).permit(:employee_id, :duty_date, :on_duty_at, :off_duty_at, :is_closed, :notes)
    end

end
