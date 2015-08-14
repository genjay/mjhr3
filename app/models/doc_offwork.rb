class DocOffwork < ActiveRecord::Base
	validates :employee_id, :employee_uid ,presence: true, uniqueness: {scope: [:employee_id, :offduty_begin_at]}

	belongs_to :employee
	belongs_to :offtype
	before_destroy :check_is_closed
	after_save :insert_daily_offworks

	def off_hours
		(self.mins_offduty == nil)? 0 : self.mins_offduty / 60
	end

	def off_hours=(hr)
		self.mins_offduty = hr.to_i * 60
	end

	def begin_time
		self.offduty_begin_at.strftime('%H:%M') if offduty_begin_at 
	end

	def begin_time=(t)
		t.delete(':')
		time = "#{t[0,2]}:#{t[2,2]}"
		self.offduty_begin_at = "#{begin_date} #{time}"
	end

	def end_time
		self.offduty_end_at.strftime('%H:%M') if offduty_end_at 
	end

	def end_time=(t)
		t.delete(':')
		time = "#{t[0,2]}:#{t[2,2]}"
		self.offduty_end_at = "#{end_date} #{time}"
	end

  def begin_date
  	self.offduty_begin_at.strftime('%Y%m%d') if offduty_begin_at 
  end

  def begin_date=(d)
  	self.offduty_begin_at = "#{d} #{begin_time}"
  end

  def end_date
  	self.offduty_end_at.strftime('%Y%m%d') if offduty_end_at 
  end

  def end_date=(d)
  	self.offduty_end_at = "#{d} #{end_time}"
  end

	def check_is_closed
	  if self.is_closed == true
	  	errors[:messages] << %Q(It's closed can't Delete)
	  	false
	  end
	end

	def insert_daily_offworks
		conn = ActiveRecord::Base.connection
		conn.execute "delete from daily_offworks where off_offwork_id=#{id}"
		sql = "Insert into daily_offworks 
		(off_offwork_id,duty_date,mins_of_duty)
		Select a.id off_offwork_id,duty_date,mins_of_duty*(case when is_holiday then include_holiday else 1 end )
		from doc_offworks a
		left join view_sch_emps b on a.employee_id=b.employee_id
		 and b.std_on < offduty_end_at and  b.std_off > offduty_begin_at
		left join offtypes c on a.offtype_id=c.id 
		where a.id = #{id};"
		conn.execute sql
	end
end
