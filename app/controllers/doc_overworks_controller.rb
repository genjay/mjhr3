class DocOverworksController < ApplicationController
  before_action :set_doc_overwork, only: [:show, :edit, :update, :destroy]

  def create_overworks
    if params[:yyyymmdd]=~ Regexp_yyyymmdd
      create = current_ou.doc_overworks.create_by_duty(current_ou.id, params[:yyyymmdd])
      redirect_to create_overworks_doc_overworks_path, :flash => { :notice => "已建立#{create}筆加班單" }
    end
  end

  # GET /worktypes
  # GET /worktypes.json
  def index
    @overworks = current_ou.doc_overworks.includes([:employee, :overtype]).order(employee_id: :asc)
  end

  # GET /worktypes/1
  # GET /worktypes/1.json
  def show
  end

  # GET /worktypes/new
  def new
    @overwork = current_ou.doc_overworks.new
    # 3.times { @worktype.workrests.build }
  end

  # GET /worktypes/1/edit
  def edit
    # 3.times { @worktype.workrests.build }
  end

  # POST /worktypes
  # POST /worktypes.json
  def create
    @overwork = current_ou.doc_overworks.new(overwork_params)
    respond_to do |format|
      if @overwork.save
        format.html { redirect_to doc_overworks_path, notice: 'Overwork was successfully created.' }
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
      if @overwork.update(overwork_params)
        format.html { redirect_to doc_overworks_path, notice: 'Overwork was successfully updated.' }
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
    items = params[:ids]
    case items
    when nil
      redirect_to doc_overworks_path, :flash => { :alert => "沒有項目被選取" }
    else
      err_msg,ok_msg,all_msg = '','',''
      params[:ids].each do |f|
        x = current_ou.doc_overworks.find(f)
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
          format.html { redirect_to doc_overworks_path, alert: all_msg }
        else
          format.html { redirect_to doc_overworks_path, notice: all_msg }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doc_overwork
      @overwork = current_ou.doc_overworks.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def overwork_params
      params.require(:doc_overwork).permit(:employee_id, :overtype_id, :duty_date, :overwork_begin_at, :overwork_end_at, :hr, :hr_h, :begin_date, :begin_time, :end_date, :end_time, :is_closed, :notes)
    end
end