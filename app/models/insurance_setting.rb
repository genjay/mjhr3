class InsuranceSetting < ActiveRecord::Base
	after_initialize :defaults

  def defaults
  	# a 普通事故保險費
  	self.a_rate ||= 9 
  	self.a_employee ||= 20
  	self.a_company ||= 70
  	# b 職業災害保險費
  	self.b_rate ||= 0.12
  	self.b_employee ||= 0
  	self.b_company ||= 100
  	# c.就業保險費
  	self.c_rate ||= 1
  	self.c_employee ||= 20
  	self.c_company ||= 70
  	# d.工資墊償基金
  	self.d_rate ||= 0.025
  	self.d_employee ||= 0
  	self.d_company ||= 100
  	# e.健保費
  	self.e_rate ||= 4.91
  	self.e_employee ||= 30
  	self.e_company ||= 60
  end
end
