class LvtypesController < ApplicationController
  before_action :set_lvtype, only: [:show, :edit, :update, :destroy]

  # GET /pay_types
  # GET /pay_types.json
  def index
    @lvtypes = current_ou.lvtypes.all.order(uid: :asc)
  end

  # GET /pay_types/1
  # GET /pay_types/1.json
  def show
  end

  # GET /pay_types/new
  def new
    @lvtype = current_ou.lvtypes.new
  end

  # GET /pay_types/1/edit
  def edit
  end

  # POST /pay_types
  # POST /pay_types.json
  def create
    @lvtype = current_ou.lvtypes.new(lvtype_params)

    respond_to do |format|
      if @lvtype.save
        format.html { redirect_to lvtypes_path, notice: 'Lvtype was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /pay_types/1
  # PATCH/PUT /pay_types/1.json
  def update
    respond_to do |format|
      if @lvtype.update(lvtype_params)
        format.html { redirect_to lvtypes_path, notice: 'Lvtype was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /pay_types/1
  # DELETE /pay_types/1.json
  # def destroy
  #   @pay_type.destroy
  #   respond_to do |format|
  #     format.html { redirect_to pay_types_url, notice: 'Pay type was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def multi_destroy 
    items = params[:ids]
    case items
    when nil
      redirect_to lvtypes_path, :flash => { :alert => "沒有項目被選取" }
    else
      err_msg,ok_msg,all_msg = '','',''
      params[:ids].each do |f|
        x = current_ou.lvtypes.find(f)
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
          format.html { redirect_to lvtypes_path, alert: all_msg }
        else
          format.html { redirect_to lvtypes_path, notice: all_msg }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lvtype
      @lvtype = current_ou.lvtypes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lvtype_params
      params.require(:lvtype).permit(:uid, :name, :memo)
    end

end
