class DocForget < ActiveRecord::Base
	validates :duty_date, format: { with: Regexp_yyyymmdd,message: "日期格式錯誤"}
	validates :begin_time, :end_time, format: { with: Regexp_HHMM,message: "時間格式錯誤" }
	validates :employee_id, :duty_date,presence: true, uniqueness: {scope: [:employee_id, :duty_date]}
	validate :check_leave?

	belongs_to :employee 
	has_one :department, through: :employee
	before_destroy :check_is_closed
	# before_validation :assign_date
	delegate :name,:uid,:leave_date, :arrive_date,
		 to: :employee, prefix: :emp, allow_nil: true
	delegate :name,:uid, to: :department, prefix: :dep, allow_nil: true
  
  def check_leave?
  	case
  	when self.emp_arrive_date > duty_date 
  		then errors[:duty_date] << %Q(此人#{emp_arrive_date} 才到職)
  		  false
  	when self.emp_leave_date != nil && duty_date > self.emp_leave_date
  		then errors[:duty_date] << %Q(此人#{emp_leave_date} 已離職)
  	 	  false
  	end
  end

	def employee_uid
		self.employee.try(:uid) 
 	end

	# def assign_date
	# 	self.begin_date =  self.std_on
	# 	self.end_date = self.std_off
	# end

	def begin_date
  	  self.on_duty_at.strftime('%Y%m%d') if on_duty_at
	end

	def begin_date=(d)
	  self.on_duty_at = "#{d} #{begin_time}"
	end

	def begin_time
		self.on_duty_at.strftime('%H:%M') if on_duty_at 
	end

	def begin_time=(t)
		t.delete(':')
		time = "#{t[0,2]}:#{t[2,2]}"
		self.on_duty_at = "#{begin_date} #{time}"
	end

	def end_date
  	  self.off_duty_at.strftime('%Y%m%d') if off_duty_at 
	end

	def end_date=(d)
	  self.off_duty_at = "#{d} #{end_time}"
	end

	def end_time
		self.off_duty_at.strftime('%H:%M') if off_duty_at 
	end

	def end_time=(t)
		t.delete(':')
		time = "#{t[0,2]}:#{t[2,2]}"
		self.off_duty_at = "#{end_date} #{time}"
	end

	def check_is_closed
	  if self.is_closed == true
	  	errors[:messages] << %Q(It's closed can't Delete)
	  	false
	  end
	end

	# def std_on
	# 	a = ViewSchEmp.find_by(ou_id: ou_id,employee_id: employee_id,duty_date: duty_date)  
 #    		a.std_on
	# end

	# def std_off
	# 	a = ViewSchEmp.find_by(ou_id: ou_id,employee_id: employee_id,duty_date: duty_date)  
 #    		a.std_off
	# end

	def self.duty_info(ouid, empid, dutydate)
		ViewSchEmp.find_by(ou_id: ouid,uid: empid,duty_date: dutydate)
	end
end
