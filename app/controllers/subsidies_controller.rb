class SubsidiesController < ApplicationController
  before_action :set_subsidy, only: [:show, :edit, :update, :destroy]

  # GET /subsidies
  # GET /subsidies.json
  def index
    @subsidies = current_ou.subsidies.all
  end

  # GET /subsidies/1
  # GET /subsidies/1.json
  def show
  end

  # GET /subsidies/new
  def new
    @subsidy = current_ou.subsidies.new
  end

  # GET /subsidies/1/edit
  def edit
  end

  # POST /subsidies
  # POST /subsidies.json
  def create
    @subsidy = current_ou.subsidies.new(subsidy_params)

    respond_to do |format|
      if @subsidy.save
        format.html { redirect_to subsidies_path, notice: 'Subsidy was successfully created.' }
        format.json { render :show, status: :created, location: @subsidy }
      else
        format.html { render :new }
        format.json { render json: @subsidy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subsidies/1
  # PATCH/PUT /subsidies/1.json
  def update
    respond_to do |format|
      if @subsidy.update(subsidy_params)
        format.html { redirect_to subsidies_path, notice: 'Subsidy was successfully updated.' }
        format.json { render :show, status: :ok, location: @subsidy }
      else
        format.html { render :edit }
        format.json { render json: @subsidy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subsidies/1
  # DELETE /subsidies/1.json
  # def destroy
  #   @subsidy.destroy
  #   respond_to do |format|
  #     format.html { redirect_to subsidies_url, notice: 'Subsidy was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def multi_destroy 
    items = params[:ids]
    case items
    when nil
      redirect_to subsidies_path, :flash => { :alert => "沒有項目被選取" }
    else
      err_msg,ok_msg,all_msg = '','',''
      params[:ids].each do |f|
        x = current_ou.subsidies.find(f)
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
          format.html { redirect_to subsidies_path, alert: all_msg }
        else
          format.html { redirect_to subsidies_path, notice: all_msg }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subsidy
      @subsidy = current_ou.subsidies.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subsidy_params
      params.require(:subsidy).permit(:uid, :name, :rate, :memo, :is_stoped)
    end
end
