class WorkrestsController < ApplicationController
    before_action :set_workrest, only: [:show, :edit, :update, :destroy]
    before_action :set_wortype_name, only: [:edit, :new]

  def index
    # @workrests = current_ou.workrests.includes(:worktype).order(id: :asc)
    @workrests = current_ou.workrests.where(:worktype_id => params[:worktype_id])
  end

  def show
  end

  def new
    @workrest = current_ou.workrests.new(worktype_id: params[:worktype_id])
  end

  def edit
  end

  def create
    @workrest = current_ou.workrests.new(workrest_params)
    @workrest.worktype_id = params[:worktype_id]
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

    def set_wortype_name
      @worktype_name = current_ou.worktypes.find(params[:worktype_id]).name
    end

    def workrest_params
      params.require(:workrest).permit(:worktype_id, :is_holiday, :rest_begin_at, :mins_of_rest, :is_deduct_for_duty, :memo)
    end

end