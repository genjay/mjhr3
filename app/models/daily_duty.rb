class DailyDuty < ActiveRecord::Base
	belongs_to :employee

	def self.d04(ou_id,duty_date)
		run_sql = ActiveRecord::Base.connection
		# sql = %Q(create table tmp01 select * from view_sch_emps where ou_id = #{ou_id} and duty_date = #{duty_date} )

		sql = %Q(Insert into daily_duties (employee_id,duty_date,ou_id,is_holiday,worktype_id,created_at,updated_at) select employee_id,duty_date,ou_id,is_holiday,worktype_id,utc_timestamp,utc_timestamp from view_sch_emps where ou_id = 1 and duty_date = #{duty_date};)
    run_sql.execute(sql)
	end
end
