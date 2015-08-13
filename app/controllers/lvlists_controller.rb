class LvlistsController < ApplicationController
  before_action :set_lvlist, only: [:show, :edit, :update, :destroy]

  # GET /lvlists
  # GET /lvlists.json
  def index
    @lvlists = current_ou.lvlists.where(:lvtype_id => params[:lvtype_id])
  end

  # GET /lvlists/1
  # GET /lvlists/1.json
  def show
  end

  # GET /lvlists/new
  def new
    @lvlist = current_ou.lvlists.new(lvtype_id: params[:lvtype_id])
  end

  # GET /lvlists/1/edit
  def edit
  end

  # POST /lvlists
  # POST /lvlists.json
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

  # PATCH/PUT /lvlists/1
  # PATCH/PUT /lvlists/1.json
  def update
    respond_to do |format|
      if @lvlist.update(lvlist_params)
        format.html { redirect_to lvtype_lvlists_path, notice: 'Lvlist was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /lvlists/1
  # DELETE /lvlists/1.json
  # def destroy
  #   @lvlist.destroy
  #   respond_to do |format|
  #     format.html { redirect_to lvlists_url, notice: 'Lvlist was successfully destroyed.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lvlist
      @lvlist = current_ou.lvlists.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lvlist_params
      params.require(:lvlist).permit(:uid, :amt, :lvtype_id, :type)
    end
end
