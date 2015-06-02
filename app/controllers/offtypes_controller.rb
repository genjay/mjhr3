class OfftypesController < ApplicationController
  before_action :set_offtype, only: [:show, :edit, :update, :destroy]

  # GET /offtypes
  # GET /offtypes.json
  def index
    @offtypes = Offtype.all
  end

  # GET /offtypes/1
  # GET /offtypes/1.json
  def show
  end

  # GET /offtypes/new
  def new
    @offtype = Offtype.new
  end

  # GET /offtypes/1/edit
  def edit
  end

  # POST /offtypes
  # POST /offtypes.json
  def create
    @offtype = Offtype.new(offtype_params)

    respond_to do |format|
      if @offtype.save
        format.html { redirect_to @offtype, notice: 'Offtype was successfully created.' }
        format.json { render :show, status: :created, location: @offtype }
      else
        format.html { render :new }
        format.json { render json: @offtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offtypes/1
  # PATCH/PUT /offtypes/1.json
  def update
    respond_to do |format|
      if @offtype.update(offtype_params)
        format.html { redirect_to @offtype, notice: 'Offtype was successfully updated.' }
        format.json { render :show, status: :ok, location: @offtype }
      else
        format.html { render :edit }
        format.json { render json: @offtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offtypes/1
  # DELETE /offtypes/1.json
  def destroy
    @offtype.destroy
    respond_to do |format|
      format.html { redirect_to offtypes_url, notice: 'Offtype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offtype
      @offtype = Offtype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offtype_params
      params.require(:offtype).permit(:uid, :name, :mins_of_minimum, :mins_per_unit, :deduct_percent, :include_holiday, :can_duplicate, :is_quota_ctrl, :is_stoped, :memo, :ou_id)
    end
end
