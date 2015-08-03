class DailyDuty < ActiveRecord::Base
	belongs_to :employee

	# def self.d04(ou_id,duty_date)
	# 	run_sql = ActiveRecord::Base.connection 
 #    sql = %Q(call p_d04(#{ou_id},'#{duty_date}')) 
 #    run_sql.execute(sql)
	# end

	def self.d04(ou_id,duty_date)
		run_sql = ActiveRecord::Base.connection
    #  產生當日應出勤人員資料' 
  	run_sql.execute("drop table if exists tmp_view_sch_emps")
		sql = %Q(create table tmp_view_sch_emps 
			Select * 
			from view_sch_emps
			where ou_id='#{ou_id}' and duty_date='#{duty_date}';)
 		run_sql.execute(sql) 

 		a = 1.days.ago(duty_date.to_date)
 		b = 2.days.since(duty_date.to_date)

 		sql = %Q(create table tmp_cardtimes
			Select *
			from cardtimes
			where dtime between '#{a}' and '#{b}')
		run_sql.execute(sql)


		# sql = %Q(drop table tmp_view_sch_emps )
		# run_sql.execute(sql)

	end
end
