class AnnualLeaveListsController < ApplicationController
  before_action :set_annual_leave_list, only: [:show, :edit, :update, :destroy]

  # GET /annual_leave_lists
  # GET /annual_leave_lists.json
  def index
    @annual_leave_lists = AnnualLeaveList.all.order(months_of_job: :asc)
  end

  # GET /annual_leave_lists/1
  # GET /annual_leave_lists/1.json
  def show
  end

  # GET /annual_leave_lists/new
  def new
    @annual_leave_list = AnnualLeaveList.new
  end

  # GET /annual_leave_lists/1/edit
  def edit
  end

  # POST /annual_leave_lists
  # POST /annual_leave_lists.json
  def create
    @annual_leave_list = AnnualLeaveList.new(annual_leave_list_params)

    respond_to do |format|
      if @annual_leave_list.save
        format.html { redirect_to annual_leave_lists_path, notice: 'Annual leave list was successfully created.' }
        format.json { render :show, status: :created, location: @annual_leave_list }
      else
        format.html { render :new }
        format.json { render json: @annual_leave_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annual_leave_lists/1
  # PATCH/PUT /annual_leave_lists/1.json
  def update
    respond_to do |format|
      if @annual_leave_list.update(annual_leave_list_params)
        format.html { redirect_to annual_leave_lists_path, notice: 'Annual leave list was successfully updated.' }
        format.json { render :show, status: :ok, location: @annual_leave_list }
      else
        format.html { render :edit }
        format.json { render json: @annual_leave_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annual_leave_lists/1
  # DELETE /annual_leave_lists/1.json
  # def destroy
  #   @annual_leave_list.destroy
  #   respond_to do |format|
  #     format.html { redirect_to annual_leave_lists_url, notice: 'Annual leave list was successfully destroyed.' }
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
      x = AnnualLeaveList.find(f)
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
          format.html { redirect_to annual_leave_lists_path, alert: all_msg }
        else
          format.html { redirect_to annual_leave_lists_path, notice: all_msg }
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annual_leave_list
      @annual_leave_list = AnnualLeaveList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def annual_leave_list_params
      params.require(:annual_leave_list).permit(:months_of_job, :days, :memo)
    end
end
