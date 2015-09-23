class LvlistsController < ApplicationController
  before_action :set_lvtype, only: [:index, :show, :new, :edit]
  before_action :set_lvlist, only: [:show, :edit, :update, :destroy]

  def index
    @lvlists = @lvtype.lvlists.order(:amt)
  end

  def show
  end

  def new
    @lvlist = current_ou.lvlists.new(lvtype_id: params[:lvtype_id])
  end

  def edit
  end

  def create
    @lvlist = current_ou.lvlists.new(lvlist_params)
    @lvlist.lvtype_id = params[:lvtype_id]
    @lvlist.lvtype_uid = @lvlist.lvtype.uid
    respond_to do |format|
      if @lvlist.save
        format.html { redirect_to lvtype_lvlists_path, notice: 'Lvlist was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @lvlist.update(lvlist_params)
        format.html { redirect_to lvtype_lvlists_path, notice: 'Lvlist was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def multi_destroy
    items = params[:ids]
    case items
    when nil
      redirect_to lvtype_lvlists_path, :flash => { :alert => "沒有項目被選取" }
    else
      err_msg,ok_msg,all_msg = '','',''
      params[:ids].each do |f|
        x = current_ou.lvlists.find(f)
        if x.destroy
          ok_msg = ok_msg << "[#{x.amt}]"
        else
          err_msg = err_msg << "[#{x.amt} 刪除失敗 " << x.errors[:base].join << '\n'
        end
      end

      all_msg = (ok_msg.size==0? '' :(ok_msg << "刪除完成\\n")) << err_msg
      # render :text => all_msg
      respond_to do |format|
        if err_msg.size>0
          format.html { redirect_to lvtype_lvlists_path, alert: all_msg }
        else
          format.html { redirect_to lvtype_lvlists_path, notice: all_msg }
        end
      end
    end
  end

  private
    def set_lvtype
      @lvtype = current_ou.lvtypes.find(params[:lvtype_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_lvlist
      @lvlist = current_ou.lvlists.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lvlist_params
      params.require(:lvlist).permit(:amt, :lvtype_id, :id)
    end
end
