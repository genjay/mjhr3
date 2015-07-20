class OvertypesController < ApplicationController
  before_action :set_overtype, only: [:show, :edit, :update, :destroy]

  def index
    @overtypes = current_ou.overtypes.order(uid: :asc)
  end

  def new
    @overtype = current_ou.overtypes.new
  end

  def edit
  end

  def create
    @overtype = current_ou.overtypes.new(overtype_params)

    respond_to do |format|
      if @overtype.save
        format.html { redirect_to overtypes_path, notice: 'Overtype was successfully created.' }
        format.json { render :show, status: :created, location: @overtype }
      else
        format.html { render :new }
        format.json { render json: @overtype.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @overtype.update(overtype_params)
        format.html { redirect_to overtypes_path, notice: 'Overtype was successfully updated.' }
        format.json { render :show, status: :ok, location: @overtype }
      else
        format.html { render :edit }
        format.json { render json: @overtype.errors, status: :unprocessable_entity }
      end
    end
  end

  def multi_destroy 
    # render :text => params
    err_msg,ok_msg,all_msg = '','',''
    # ok_msg = 'yyy'
    # render :text => ok_msg
    # return
    params[:ids].each do |f|
      x = current_ou.overtypes.find(f)
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
          format.html { redirect_to overtypes_path, alert: all_msg }
        else
          format.html { redirect_to overtypes_path, notice: all_msg }
        end
      end
    
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_overtype
      @overtype = current_ou.overtypes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def overtype_params
      params.require(:overtype).permit(:uid, :name, :mins_of_A, :mins_of_B, :rate_of_A, :amt_of_A, :rate_of_B, :amt_of_B, :rate_of_C, :amt_of_C, :rate_of_H, :amt_of_H, :mins_per_unit, :valid_unit, :is_stoped, :pay_type, :memo)
    end
end
