class WorktypesController < ApplicationController
  before_action :set_worktype, only: [:show, :edit, :update, :destroy]

  # GET /worktypes
  # GET /worktypes.json
  def index
    @worktypes = current_ou.worktypes.all.order(uid: :asc)
  end

  # GET /worktypes/1
  # GET /worktypes/1.json
  def show
  end

  # GET /worktypes/new
  def new
    @worktype = current_ou.worktypes.new
    # 3.times { @worktype.workrests.build }
  end

  # GET /worktypes/1/edit
  def edit
    # 3.times { @worktype.workrests.build }
  end

  # POST /worktypes
  # POST /worktypes.json
  def create
    @worktype = current_ou.worktypes.new(worktype_params)

    respond_to do |format|
      if @worktype.save
        format.html { redirect_to worktypes_path, notice: 'Worktype was successfully created.' }
        format.json { render :show, status: :created, location: @worktype }
      else
        format.html { render :new }
        format.json { render json: @worktype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /worktypes/1
  # PATCH/PUT /worktypes/1.json
  def update
    respond_to do |format|
      if @worktype.update(worktype_params)
        format.html { redirect_to worktypes_path, notice: 'Worktype was successfully updated.' }
        format.json { render :show, status: :ok, location: @worktype }
      else
        format.html { render :edit }
        format.json { render json: @worktype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /worktypes/1
  # DELETE /worktypes/1.json
  # def destroy
  #   @worktype.destroy
  #   respond_to do |format|
  #     format.html { redirect_to worktypes_url, notice: 'Worktype was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def multi_destroy
    items = params[:ids]
    case items
    when nil
      redirect_to worktypes_path, :flash => { :alert => "沒有項目被選取" }
    else
      err_msg,ok_msg,all_msg = '','',''
      params[:ids].each do |f|
        x = current_ou.worktypes.find(f)
        if x.destroy
          ok_msg = ok_msg << "[#{x.uid} #{x.name}]"
        else
          err_msg = err_msg << "[#{x.uid} #{x.name}] 刪除失敗 " << x.errors[:base].join << '\n'
        end
      end

      all_msg = (ok_msg.size==0? '' :(ok_msg << "刪除完成\\n")) << err_msg
      # render :text => all_msg
      respond_to do |format|
        if err_msg.size>0
          format.html { redirect_to worktypes_path, alert: all_msg }
        else
          format.html { redirect_to worktypes_path, notice: all_msg }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worktype
      @worktype = current_ou.worktypes.find(params[:id])
      @worktype.on_duty_at=@worktype.on_duty_at.strftime('%H:%M')
      @worktype.off_duty_at=@worktype.off_duty_at.strftime('%H:%M')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def worktype_params
      params.require(:worktype).permit(:uid, :name, :on_duty_at, :off_duty_at, :buffer_before_duty, :buffer_after_duty, :minimum_before_overwork, :minimum_after_overwork, :minimum_holiday_overwork, :range_on, :range_off, :is_stoped, :mins_of_duty, :memo, :ou_id,workrests_attributes: [:id,:worktype_id,:is_holiday,:rest_begin_at,:mins_of_rest,:is_deduct_for_duty,:memo,:_destroy])
    end
end
