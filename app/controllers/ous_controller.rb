class OusController < ApplicationController
  before_action :set_ou, only: [:show, :edit, :update, :destroy]

  # GET /ous
  # GET /ous.json
  def index
 
    @ous = Ou.all
  end

  # GET /ous/1
  # GET /ous/1.json
  def show
  end

  # GET /ous/new
  def new
    @ou = Ou.new
  end

  # GET /ous/1/edit
  def edit
  end

  # POST /ous
  # POST /ous.json
  def create
    @ou = Ou.new(ou_params)

    respond_to do |format|
      if @ou.save
        format.html { redirect_to @ou, notice: 'Ou was successfully created.' }
        format.json { render :show, status: :created, location: @ou }
      else
        format.html { render :new }
        format.json { render json: @ou.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ous/1
  # PATCH/PUT /ous/1.json
  def update
    respond_to do |format|
      if @ou.update(ou_params)
        format.html { redirect_to @ou, notice: 'Ou was successfully updated.' }
        format.json { render :show, status: :ok, location: @ou }
      else
        format.html { render :edit }
        format.json { render json: @ou.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ous/1
  # DELETE /ous/1.json
  def destroy
    @ou.destroy
    respond_to do |format|
      format.html { redirect_to ous_url, notice: 'Ou was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ou
      @ou = Ou.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ou_params
      params.require(:ou).permit(:uid, :name, :overwork_hours_for_freetax, :days_per_month, :hours_per_day, :LP_rate, :welfare_rate, :memo)
    end
end
