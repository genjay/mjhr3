class LvlistsController < ApplicationController
  before_action :set_lvlist, only: [:show, :edit, :update, :destroy]

  # GET /lvlists
  # GET /lvlists.json
  def index
    @lvlists = Lvlist.all
  end

  # GET /lvlists/1
  # GET /lvlists/1.json
  def show
  end

  # GET /lvlists/new
  def new
    @lvlist = Lvlist.new
  end

  # GET /lvlists/1/edit
  def edit
  end

  # POST /lvlists
  # POST /lvlists.json
  def create
    @lvlist = Lvlist.new(lvlist_params)

    respond_to do |format|
      if @lvlist.save
        format.html { redirect_to @lvlist, notice: 'Lvlist was successfully created.' }
        format.json { render :show, status: :created, location: @lvlist }
      else
        format.html { render :new }
        format.json { render json: @lvlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lvlists/1
  # PATCH/PUT /lvlists/1.json
  def update
    respond_to do |format|
      if @lvlist.update(lvlist_params)
        format.html { redirect_to @lvlist, notice: 'Lvlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @lvlist }
      else
        format.html { render :edit }
        format.json { render json: @lvlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lvlists/1
  # DELETE /lvlists/1.json
  def destroy
    @lvlist.destroy
    respond_to do |format|
      format.html { redirect_to lvlists_url, notice: 'Lvlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lvlist
      @lvlist = Lvlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lvlist_params
      params.require(:lvlist).permit(:uid, :amt, :ou_id)
    end
end
