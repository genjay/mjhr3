class ViewWorkrest < ActiveRecord::Base

  def self.get_rest(worktype_id,is_holiday,dt_st,dt_end)
  	# 只能計算當日的休息時間
  	x = self.select("case when '#{dt_st}' between rest_st and rest_end then '#{dt_st}' else rest_st end rest_st,case when '#{dt_end}' between rest_st and rest_end then '#{dt_end}' else rest_end end rest_end").where("worktype_id= :a and is_holiday= :b and rest_st< :c and rest_end> :d",a: worktype_id,b: is_holiday,c:dt_end,d:dt_st)
  	seconds = 0 
  	y = x.each do |i| 
  		seconds += (i.rest_end - i.rest_st)
  	end
  	return seconds/60
  end

	def readonly?
		true
	end
end
