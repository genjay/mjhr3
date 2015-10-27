class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :current_ou

  def current_ou
    #TODO
    #這應該做成活動的，使用者登入後，選擇他要的ou環境 
    Ou.find_by(uid: "16130535")
  end

  def get_empid
    @employee = current_ou.employees.find_by(uid:params[:uid])
    if @employee == nil
      render :text => ""
    else
      render :text => "#{@employee.name},#{@employee.id},#{@employee.overtype_id},#{@employee.department.name}"
    end
  end

end
