class DocOverwork < ActiveRecord::Base
	validates :employee_id, :duty_date, uniqueness: {scope: [:employee_id, :duty_date]}
	validates :hr, :hr_h, inclusion: { :in => 0..24,message:"只能輸入0~24" }

	belongs_to :employee
	belongs_to :overtype
	before_destroy :check_is_closed

	def self.create_by_duty(ou_id,duty_date) # 自動輸入加班
		x = ViewForOver.where(ou_id:ou_id,duty_date:duty_date)
	  need_columns = self.column_names  
	  need_columns<<'hr'
		h = x.map do |i| 
			i.attributes.slice(*need_columns) 
		end
		self.create(h)
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
		(self.mins_A + self.mins_B + self.mins_C)/60
	end

	def hr=(hrs)

		mins = hrs.to_i * 60
		self.mins_A = (mins>120)? 120:mins
		mins = mins - mins_A
		self.mins_B = (mins>120)? 120:mins
		mins = mins - mins_B
		self.mins_C = mins
	end

	def hr_h # 假日時數，指 0820~1720 部份
		self.mins_H/60
	end

	def hr_h=(hrs)
		mins = hrs.to_i * 60
		self.mins_H = mins
	end

end
