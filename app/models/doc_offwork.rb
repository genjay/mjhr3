class DocOffwork < ActiveRecord::Base
	validates :employee_id, presence: true, uniqueness: {scope: [:employee_id, :offduty_begin_at]}
	belongs_to :employee
	belongs_to :offtype
	has_many :details, class_name: "DailyOffwork", foreign_key: "doc_offwork_id"
	before_destroy :check_is_closed
	after_save :insert_daily_offworks
	validate :check_overlap, :check_is_closed, :begin_greater_than_end

	def employee_uid
		self.employee.try(:uid) 
	end

	def sum_offhours
		self.details.sum(:mins_of_duty)/60
	end

	def off_hours
		x = self.details.sum(:mins_of_duty)/60
    # "#{x.to_f/8} 天" if x>8
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
	  	# errors[:messages] << %Q(It's closed can't Delete)
	  	errors.add(:begin_date,"關帳")
	  end
	end

# private

	def insert_daily_offworks
		conn = ActiveRecord::Base.connection
		conn.execute "delete from daily_offworks where doc_offwork_id=#{id}"
		sql = "Insert into daily_offworks 
		(doc_offwork_id,duty_date,mins_of_duty)
		Select a.id doc_offwork_id,duty_date,mins_of_duty*(case when is_holiday then include_holiday else 1 end )
		from doc_offworks a
		left join view_sch_emps b on a.employee_id=b.employee_id
		 and b.std_on < offduty_end_at and  b.std_off > offduty_begin_at
		left join offtypes c on a.offtype_id=c.id 
		where a.id = #{id};"
		conn.execute sql
	end

  def check_overlap
  	#檢查是否有另一張重疊的假單
  	cnt = self.class.where("employee_id= ? and offduty_begin_at < ? and offduty_end_at > ? and id != ?",employee_id,offduty_end_at,offduty_begin_at,id).count
  	if cnt > 0
		  errors.add(:begin_date,"與另一張請假單發現重疊")
		end 
  end

  def begin_greater_than_end
  	if offduty_begin_at >= offduty_end_at 
  		errors.add(:begin_date,"請假起迄有錯")
  	end
  end

end

