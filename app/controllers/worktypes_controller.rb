class WorktypesController < ApplicationController
  before_action :set_worktype, only: [:show, :edit, :update, :destroy]

  # GET /worktypes
  # GET /worktypes.json
  def index
    @worktypes = Worktype.all
  end

  # GET /worktypes/1
  # GET /worktypes/1.json
  def show
  end

  # GET /worktypes/new
  def new
    @worktype = Worktype.new
  end

  # GET /worktypes/1/edit
  def edit
  end

  # POST /worktypes
  # POST /worktypes.json
  def create
    @worktype = Worktype.new(worktype_params)

    respond_to do |format|
      if @worktype.save
        format.html { redirect_to @worktype, notice: 'Worktype was successfully created.' }
        format.json { render :show, status: :created, location: @worktype }
      else
        format.html { render :new }
        format.json { render json: @worktype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /worktypes/1
  # PATCH/PUT /worktypes/1.json
  def update
    respond_to do |format|
      if @worktype.update(worktype_params)
        format.html { redirect_to @worktype, notice: 'Worktype was successfully updated.' }
        format.json { render :show, status: :ok, location: @worktype }
      else
        format.html { render :edit }
        format.json { render json: @worktype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /worktypes/1
  # DELETE /worktypes/1.json
  def destroy
    @worktype.destroy
    respond_to do |format|
      format.html { redirect_to worktypes_url, notice: 'Worktype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worktype
      @worktype = Worktype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def worktype_params
      params.require(:worktype).permit(:uid, :name, :on_duty_at, :off_duty_at, :buffer_before_duty, :buffer_after_duty, :minimum_before_overwork, :minimum_after_overwork, :minimum_holiday_overwork, :range_on, :range_off, :is_stoped, :mins_of_duty, :memo, :ou_id)
    end
end
