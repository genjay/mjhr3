class MonthOthersController < ApplicationController
  before_action :set_month_other, only: [:show, :edit, :update, :destroy]

  # GET /month_others
  # GET /month_others.json
  def index
    @month_others = current_ou.month_others.all
  end

  # GET /month_others/1
  # GET /month_others/1.json
  def show
  end

  # GET /month_others/new
  def new
    @month_other = current_ou.month_others.new
    @month_other.month_other_details.build
  end

  # GET /month_others/1/edit
  def edit
  end

  # POST /month_others
  # POST /month_others.json
  def create
    doc_no = current_ou.month_others.next_docno(current_ou.id)
    @month_other = current_ou.month_others.new(month_other_params)
    @month_other.doc_no = doc_no

    respond_to do |format|
      if @month_other.save
        format.html { redirect_to @month_other, notice: 'Month other was successfully created.' }
        format.json { render :show, status: :created, location: @month_other }
      else
        format.html { render :new }
        format.json { render json: @month_other.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /month_others/1
  # PATCH/PUT /month_others/1.json
  def update
    respond_to do |format|
      if @month_other.update(month_other_params)
        format.html { redirect_to @month_other, notice: 'Month other was successfully updated.' }
        format.json { render :show, status: :ok, location: @month_other }
      else
        format.html { render :edit }
        format.json { render json: @month_other.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /month_others/1
  # DELETE /month_others/1.json
  def destroy
    @month_other.destroy
    respond_to do |format|
      format.html { redirect_to month_others_url, notice: 'Month other was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_month_other
      @month_other = current_ou.month_others.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def month_other_params
      params.require(:month_other).permit(
        :name, :yyyymm, :pay_type_id, :month_other_id, :employee_id, :amt,
        month_other_details_attributes:[:month_other_id, :employee_id, :amt, :_destroy]
      )
    end
end
