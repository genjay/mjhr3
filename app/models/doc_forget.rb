class DocForget < ActiveRecord::Base
	validates :employee_id, :duty_date,presence: true, uniqueness: {scope: [:employee_id, :duty_date]}

	belongs_to :employee 
	before_destroy :check_is_closed

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

	def duty_info
		ViewSchEmp.find_by(ou_id: ou_id,employee_id: employee_id,duty_date: duty_date)
	end
end
