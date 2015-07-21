class DocOffworksController < ApplicationController
  before_action :set_doc_offwork, only: [:show, :edit, :update, :destroy]

  # GET /worktypes
  # GET /worktypes.json
  def index
    @offworks = current_ou.doc_offworks.includes(:employee).order(employee_id: :asc)
  end

  # GET /worktypes/1
  # GET /worktypes/1.json
  def show
  end

  # GET /worktypes/new
  def new
    @offwork = current_ou.doc_offworks.new
    # 3.times { @worktype.workrests.build }
  end

  # GET /worktypes/1/edit
  def edit
    # 3.times { @worktype.workrests.build }
  end

  # POST /worktypes
  # POST /worktypes.json
  def create
    @offwork = current_ou.doc_offworks.new(offwork_params)

    respond_to do |format|
      if @offwork.save
        format.html { redirect_to doc_offworks_path, notice: 'Offwork was successfully created.' }
        # format.json { render :show, status: :created, location: @forget }
      else
        format.html { render :new }
        # format.json { render json: @forget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /worktypes/1
  # PATCH/PUT /worktypes/1.json
  def update
    respond_to do |format|
      if @offwork.update(offwork_params)
        format.html { redirect_to doc_offworks_path, notice: 'Offwork was successfully updated.' }
        # format.json { render :show, status: :ok, location: @forget }
      else
        format.html { render :edit }
        # format.json { render json: @forget.errors, status: :unprocessable_entity }
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
    # render :text => params
    err_msg,ok_msg,all_msg = '','',''
    # ok_msg = 'yyy'
    # render :text => ok_msg
    # return
    params[:ids].each do |f|
      x = current_ou.doc_offworks.find(f)
      if x.destroy
        ok_msg = ok_msg << "[#{x.employee_id} #{x.employee.name}]"
      else
        err_msg = err_msg << "[#{x.employee_id} #{x.employee.name}] 刪除失敗 " << x.errors[:base].join << '\n'
      end
    end

      all_msg = (ok_msg.size==0? '' :(ok_msg << "刪除完成\\n")) << err_msg
      # render :text => all_msg
      respond_to do |format|
        if err_msg.size>0
          format.html { redirect_to doc_offworks_path, alert: all_msg }
        else
          format.html { redirect_to doc_offworks_path, notice: all_msg }
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doc_offwork
      @offwork = current_ou.doc_offworks.find(params[:id])
      # @forget.on_duty_at=@forget.on_duty_at.strftime('%H:%M')
      # @forget.off_duty_at=@forget.off_duty_at.strftime('%H:%M')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offwork_params
      params.require(:doc_offwork).permit(:employee_id, :offtype_id, :offduty_begin_at, :offduty_end_at, :mins_offduty, :is_closed, :notes)
    end
end