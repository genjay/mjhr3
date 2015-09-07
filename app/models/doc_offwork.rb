class DocOffwork < ActiveRecord::Base
	validates :employee_id, presence: true, uniqueness: {scope: [:employee_id, :offduty_begin_at]}
	belongs_to :employee
	belongs_to :offtype
	has_many :details, class_name: "DailyOffwork", foreign_key: "doc_offwork_id", :dependent => :delete_all
	before_destroy :check_is_closed
	after_save :create_details
	validate :check_overlap, :check_is_closed, :begin_greater_than_end

  def self.off_mins(ou_id,emp_uid,dt_st,dt_end)
  	# 回傳請假的總時數
  	x = ViewSchEmp.where("ou_id= :ou_id and uid= :emp_uid and std_on < :dt_end and std_off > :dt_st",ou_id: ou_id,emp_uid: emp_uid,dt_st: dt_st,dt_end: dt_end)
  	off_mins = 0
  	b = 0
  	x.each do |i| 
  		i.std_on = dt_st if dt_st.between?(i.std_on,i.std_off) 
  		i.std_off = dt_end if dt_end.between?(i.std_on,i.std_off)
  		y = ViewWorkrest.get_rest(i.worktype_id,i.is_holiday,i.std_on,i.std_off) 
  		off_mins += (i.std_off - i.std_on)/60 - y 
  	end
  	return off_mins/60
  end

	def employee_uid
		self.employee.try(:uid) 
	end 

	def off_hours
		x = self.details.sum(:mins_of_duty).to_f/60
    # "#{x.to_f/8} 天" if x>8
	end

	def off_hours=(hr)
		self.mins_offduty = hr.to_i * 60
	end

	def begin_time
		self.offduty_begin_at.strftime('%H:%M') if offduty_begin_at 
	end

	def begin_time=(t)
		t.delete!(':')
		time = "#{t[0,2]}:#{t[2,2]}"
		self.offduty_begin_at = "#{begin_date} #{time}"
	end

	def end_time
		self.offduty_end_at.strftime('%H:%M') if offduty_end_at 
	end

	def end_time=(t)
		t.delete!(':')
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
  def create_details
  	x = ViewSchEmp.select(:employee_id,:duty_date,:worktype_id,:is_holiday,:std_on,:std_off).where("ou_id= :ou_id and employee_id= :employee_id and std_on < :offduty_end_at and std_off > :offduty_begin_at",ou_id: ou_id,employee_id: employee_id,offduty_end_at: offduty_end_at,offduty_begin_at: offduty_begin_at).order(:duty_date)
  	self.details.delete_all
  	x.each do |i|
  		old_on,old_off = i.std_on,i.std_off
  	  i.std_on=offduty_begin_at if self.offduty_begin_at.between?(old_on,old_off)
  	  i.std_off=offduty_end_at if self.offduty_end_at.between?(old_on,old_off)
  	  if i.is_holiday == 1 && self.offtype.include_holiday == false
  	  	mins=0
  	  else
	  	  mins = (i.std_off - i.std_on)/60 - ViewWorkrest.get_rest(i.worktype_id,i.is_holiday,i.std_on,i.std_off) 
	  	  # 因請假以小時為最小單位，所以要除60，無條件進位後在乘60換成分
	  	  unit = self.offtype.mins_per_unit
	  	  mins = (mins.to_f/unit).ceil*unit
	  	end
  	  self.details.create(duty_date: i.duty_date,mins_of_duty: mins)
    end 
  end

  def check_overlap
  	#檢查是否有另一張重疊的假單
  	# offduty_begin_at = "#{begin_date} #{begin_time}"
  	# offduty_end_at = "#{end_date} #{end_time}"
  	id = (self.id==nil)? 0:self.id
  	cnt = self.class.where("employee_id= ? and offduty_begin_at < ? and offduty_end_at > ? and id != ?",employee_id,offduty_end_at,offduty_begin_at,id).count
  	if cnt > 0
		  errors.add(:begin_date,"與另一張請假單發現重疊")
		end 
  end

  def begin_greater_than_end
    if offduty_begin_at != nil
  	if offduty_begin_at >= offduty_end_at 
  		errors.add(:begin_date,"請假起迄有錯")
  	end
    end
  end

end

