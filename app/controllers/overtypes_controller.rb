class OvertypesController < ApplicationController
  before_action :set_overtype, only: [:show, :edit, :update, :destroy]

  # GET /overtypes
  # GET /overtypes.json
  def index
    @overtypes = Overtype.all.order(uid: :asc)
  end

  # GET /overtypes/1
  # GET /overtypes/1.json
  def show
  end

  # GET /overtypes/new
  def new
    @overtype = Overtype.new
  end

  # GET /overtypes/1/edit
  def edit
  end

  # POST /overtypes
  # POST /overtypes.json
  def create
    @overtype = Overtype.new(overtype_params)

    respond_to do |format|
      if @overtype.save
        format.html { redirect_to @overtype, notice: 'Overtype was successfully created.' }
        format.json { render :show, status: :created, location: @overtype }
      else
        format.html { render :new }
        format.json { render json: @overtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /overtypes/1
  # PATCH/PUT /overtypes/1.json
  def update
    respond_to do |format|
      if @overtype.update(overtype_params)
        format.html { redirect_to @overtype, notice: 'Overtype was successfully updated.' }
        format.json { render :show, status: :ok, location: @overtype }
      else
        format.html { render :edit }
        format.json { render json: @overtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /overtypes/1
  # DELETE /overtypes/1.json
  def destroy
    @overtype.destroy
    respond_to do |format|
      format.html { redirect_to overtypes_url, notice: 'Overtype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_overtype
      @overtype = Overtype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def overtype_params
      params.require(:overtype).permit(:uid, :name, :mins_of_A, :mins_of_B, :rate_of_A, :amt_of_A, :rate_of_B, :amt_of_B, :rate_of_C, :amt_of_C, :rate_of_H, :amt_of_H, :mins_per_unit, :valid_unit, :is_stoped, :pay_type, :memo, :ou_id)
    end
end
