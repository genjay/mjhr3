class SubsidiesController < ApplicationController
  before_action :set_subsidy, only: [:show, :edit, :update, :destroy]

  # GET /subsidies
  # GET /subsidies.json
  def index
    @subsidies = Subsidy.all
  end

  # GET /subsidies/1
  # GET /subsidies/1.json
  def show
  end

  # GET /subsidies/new
  def new
    @subsidy = Subsidy.new
  end

  # GET /subsidies/1/edit
  def edit
  end

  # POST /subsidies
  # POST /subsidies.json
  def create
    @subsidy = Subsidy.new(subsidy_params)

    respond_to do |format|
      if @subsidy.save
        format.html { redirect_to @subsidy, notice: 'Subsidy was successfully created.' }
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
        format.html { redirect_to @subsidy, notice: 'Subsidy was successfully updated.' }
        format.json { render :show, status: :ok, location: @subsidy }
      else
        format.html { render :edit }
        format.json { render json: @subsidy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subsidies/1
  # DELETE /subsidies/1.json
  def destroy
    @subsidy.destroy
    respond_to do |format|
      format.html { redirect_to subsidies_url, notice: 'Subsidy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subsidy
      @subsidy = Subsidy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subsidy_params
      params.require(:subsidy).permit(:uid, :name, :rate, :memo, :is_stoped, :ou_id)
    end
end
