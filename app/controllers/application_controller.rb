class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # before_action :assign_current_ou
  helper_method :current_ou
 


  # 此法無法將@ou_id 在model內用 
  # before_action :set_default
  # def set_default
  # 	@ou_uid ||= '16130535'
  # 	@ou_id = Ou.where(uid:@ou_uid).pluck(:id)
  # 	@ou_id = 1
  # end
  # def assign_current_ou
  #   @current_ou = Ou.find_by(uid: "16130535")
  # end

  def current_ou
    Ou.find_by(uid: "16130535")
  end
end
