class DocOverwork < ActiveRecord::Base
	validates :employee_id, :duty_date, presence: true, uniqueness: {scope: [:employee_id, :duty_date]}
	validates :hr, inclusion: { :in => 0..24,message:"只能輸入0~24" }

	belongs_to :employee
	belongs_to :overtype
	before_destroy :check_is_closed

	def employee_uid
		self.employee.try(:uid)
	end

	def self.create_by_duty(ou_id,duty_date) # 自動輸入加班
		x = ViewForOver.where(ou_id:ou_id,duty_date:duty_date)
	  need_columns = self.column_names  
	  need_columns<<'hr'
		h = x.map do |i| 
			i.attributes.slice(*need_columns) 
		end
		self.create(h)
		return h.size
	end

	def begin_time
		self.overwork_begin_at.strftime('%H:%M') if overwork_begin_at 
	end
	
	def begin_time=(t)
		t.delete(':')
		time = "#{t[0,2]}:#{t[2,2]}"
		self.overwork_begin_at = "#{begin_date} #{time}"
	end

	def end_time
		self.overwork_end_at.strftime('%H:%M') if overwork_end_at 
	end

	def end_time=(t)
		t.delete(':')
		time = "#{t[0,2]}:#{t[2,2]}"
		self.overwork_end_at = "#{end_date} #{time}"
	end

	def begin_date
	    self.overwork_begin_at.strftime('%Y%m%d') if overwork_begin_at 
	end

	def begin_date=(d)
	    self.overwork_begin_at = "#{d} #{begin_time}"
	end

	def end_date
	    self.overwork_end_at.strftime('%Y%m%d') if overwork_end_at 
	end

	def end_date=(d)
	    self.overwork_end_at = "#{d} #{end_time}"
	end

	def check_is_closed
	  if self.is_closed == true
	  	errors[:messages] << %Q(It's closed can't Delete)
	  	false
	  end
	end

	def hr # 加班時數，指1750後的加班 
		(self.mins_A + self.mins_B + self.mins_C + self.mins_H)/60
	end

	def hr=(hrs)
		mins = hrs.to_i * 60
		if is_holiday == 0
			self.mins_A = (mins>120)? 120:mins
			mins = mins - mins_A
			self.mins_B = (mins>120)? 120:mins
			mins = mins - mins_B
			self.mins_C = mins
		else
			self.mins_H = mins
		end
	end

	def hr_a
		self.mins_A = self.mins_A/60
	end

	def hr_a=(hrs)
		self.mins_A = hrs.to_i * 60
	end

	def hr_b
		self.mins_B = self.mins_B/60
	end

	def hr_b=(hrs)
		self.mins_B = hrs.to_i * 60
	end

	def hr_c
		self.mins_C = self.mins_C/60
	end

	def hr_c=(hrs)
		self.mins_C = hrs.to_i * 60
	end

	def hr_h
		self.mins_H = self.mins_H/60
	end

	def hr_h=(hrs)
		self.mins_H = hrs.to_i * 60
	end

	def is_holiday
		holiday = ViewSchEmp.find_by(employee_id:self.employee_id, duty_date:self.duty_date)
		if holiday != nil
		  return holiday.is_holiday
		end
	end

	# def hr_h # 假日時數，指 0820~1720 部份
	# 	self.mins_H/60
	# end

	# def hr_h=(hrs)
	# 	mins = hrs.to_i * 60
	# 	self.mins_H = mins
	# end

end
