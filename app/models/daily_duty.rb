class DailyDuty < ActiveRecord::Base
	belongs_to :employee

	def self.d04(ou_id,duty_date)
		run_sql = ActiveRecord::Base.connection 
    sql = %Q(call p_d04(#{ou_id},'#{duty_date}')) 
    run_sql.execute(sql)
	end
end
