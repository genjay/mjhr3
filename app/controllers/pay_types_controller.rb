class PayTypesController < ApplicationController
  before_action :set_pay_type, only: [:show, :edit, :update, :destroy]

  # GET /pay_types
  # GET /pay_types.json
  def index
    @pay_types = current_ou.pay_types.all.order(uid: :asc)
  end

  # GET /pay_types/1
  # GET /pay_types/1.json
  def show
  end

  # GET /pay_types/new
  def new
    set_lists
    @pay_type = current_ou.pay_types.new
    # @pay_type.cycle_unit = 'A'

    # render :text => @cycle_unit_lists
  end

  # GET /pay_types/1/edit
  def edit
    set_lists
    # @cycle_unit_lists = Catcode.lists('pay_type','cycle_unit')
    # @rule_for_break_lists = Catcode.lists('pay_type','rule_for_break')
    # @cycle_unit_lists = Catcode.where("m_name='pay_type' and col_name='cycle_unit'").pluck("concat(uid,' ',name),uid") 
    # @rule_for_break_lists = Catcode.where("m_name='pay_type' and col_name='rule_for_break'").pluck("concat(uid,' ',name),uid")
    
  end

  # POST /pay_types
  # POST /pay_types.json
  def create
    @pay_type = current_ou.pay_types.new(pay_type_params)

    respond_to do |format|
      if @pay_type.save
        format.html { redirect_to pay_types_path, notice: 'Pay type was successfully created.' }
        format.json { render :show, status: :created, location: @pay_type }
      else
        format.html { render :new }
        format.json { render json: @pay_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pay_types/1
  # PATCH/PUT /pay_types/1.json
  def update
    respond_to do |format|
      if @pay_type.update(pay_type_params)
        format.html { redirect_to pay_types_path, notice: 'Pay type was successfully updated.' }
        format.json { render :show, status: :ok, location: @pay_type }
      else
        format.html { render :edit }
        format.json { render json: @pay_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_types/1
  # DELETE /pay_types/1.json
  # def destroy
  #   @pay_type.destroy
  #   respond_to do |format|
  #     format.html { redirect_to pay_types_url, notice: 'Pay type was successfully destroyed.' }
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
      x = current_ou.pay_types.find(f)
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
          format.html { redirect_to pay_types_path, alert: all_msg }
        else
          format.html { redirect_to pay_types_path, notice: all_msg }
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pay_type
      @pay_type = current_ou.pay_types.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pay_type_params
      params.require(:pay_type).permit(:uid, :name, :cycle_unit, :rule_for_break, :is_stoped, :memo)
    end

    def set_lists # 下單選單用 
      @cycle_unit_lists = Option.of(PayType,'cycle_unit') #.cycle_options #[["A 月薪", "pay_by_month"], ["B 時薪", "pay_by_hour"], ["C 日薪", "pay_by_day"]]
      @rule_for_break_lists = Option.of(PayType,'rule_for_break') #rule_options #[["A 依出勤比率", "rate_by_duty"], ["B 全給付", "pay_all"], ["C 手動輸入", "pay_by_user_keyin"] ]
      
    end
end
