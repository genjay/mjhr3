class DailyDuty < ActiveRecord::Base
	belongs_to :employee

	# def self.d04(ou_id,duty_date)
	# 	run_sql = ActiveRecord::Base.connection 
 #    sql = %Q(call p_d04(#{ou_id},'#{duty_date}')) 
 #    run_sql.execute(sql)
	# end

	def self.d04(ou_id,duty_date,*sid) # 日結
    run_sql = ActiveRecord::Base.connection  
    tmpfiles = []
    tmp01 = "tmp01" #<< sid
    if true # 產生 tmp01 like daily_duties
    	run_sql.execute "drop table if exists #{tmp01}"
    	run_sql.execute "create table #{tmp01} select * from daily_duties limit 0"
    end

    if true  # 利用 view_sch_emps 產生當日應出勤人員，相關資料
      columns = DailyDuty.column_names && ViewSchEmp.column_names
      columns = columns.join(',')
      sql = "INSERT INTO #{tmp01} (#{columns}) SELECT #{columns} FROM view_sch_emps WHERE ou_id='#{ou_id}' and duty_date='#{duty_date}')"
    	run_sql.execute sql
    end
	end

	def self.d04_old(ou_id,duty_date) # 日結
		run_sql = ActiveRecord::Base.connection 
		temp = Rails.env=='production'? 'temporary':'' 
    tmpfiles = []
		if true # 01 產生當日應出勤人員資料' 
			tmp01 = 'tmp_view_sch_emps'  
			tmpfiles = tmpfiles << tmp01
	  	run_sql.execute("drop table if exists #{tmp01}")
			sql = %Q(create #{temp} table #{tmp01} 
				Select a.*
				, a.std_on - interval range_on minute range_a
				,a.std_off + interval range_off minute range_b
				from view_sch_emps a
				where ou_id='#{ou_id}' and duty_date='#{duty_date}';)
	 		run_sql.execute(sql) 
	 		run_sql.execute("alter table #{tmp01} add index i01 (employee_id)")
	 	end
 
 		#=========================================================
		if true # 02 計算取得(出勤日)前一日~後二日的刷卡資料
			a = 1.days.ago(duty_date.to_date)
			b = 2.days.since(duty_date.to_date)
      tmp02 = 'tmp_cardtimes'
			tmpfiles = tmpfiles << tmp02
			run_sql.execute("drop table if exists #{tmp02}")
			sql = %Q(create #{temp} table tmp_cardtimes
			Select id,up_data,created_at,updated_at,ou_id,cardno,concat(substring(dtime,1,16),':00') dtime
			from cardtimes
			where dtime between '#{a}' and '#{b}')
			run_sql.execute(sql)
			run_sql.execute("alter table #{tmp02} add index i01 (cardno,dtime)")
		end

    if true # 03 計算上下班時間
    	tmp03 = 'tmp_duty'
			tmpfiles = tmpfiles << tmp03
    	run_sql.execute("drop table if exists #{tmp03}")
    	sql = %Q(create #{temp} table #{tmp03} 
    		select a.cardno,a.ou_id,a.employee_id,a.duty_date,a.worktype_id,is_holiday,std_on,std_off
				,min(dtime) real_on,max(dtime) real_off
				,case when min(dtime) < std_on then min(dtime) else std_on end aa
				,case when max(dtime) > std_off then max(dtime) else std_off end bb
				from tmp_view_sch_emps a
				left join tmp_cardtimes b on a.cardno=b.cardno and b.dtime between a.range_a and a.range_b
				group by a.employee_id;)
    	run_sql.execute sql
    end

    if true # 04 依tmp03 加上，上班 前中後起迄 
    	tmp04 = 'tmp04'
			tmpfiles = tmpfiles << tmp04
    	run_sql.execute("drop table if exists #{tmp04}")
    	sql = "create #{temp} table #{tmp04}
    		select employee_id,worktype_id,is_holiday,'working' type
				,case when std_on > real_on then std_on else real_on end type_start
				,case when real_off > std_off then std_off else real_off end type_end
				from tmp_duty union all
				select employee_id,worktype_id,is_holiday,'before' type,aa,std_on
				from tmp_duty union all
				select employee_id,worktype_id,is_holiday,'after' type,std_off,bb
				from tmp_duty " 
    	run_sql.execute(sql) 
    end

    if true #05 產生需要的休息時刻表 
    	tmp05 = 'tmp05'
			tmpfiles = tmpfiles << tmp05
			a = 1.days.ago(duty_date.to_date)
			b = 2.days.since(duty_date.to_date)
    	run_sql.execute("drop table if exists #{tmp05}")
    	sql = %Q(create #{temp} table #{tmp05}
    		select * 
    		from view_workrests 
    		where ou_id = #{ou_id} and duty_date between '#{a}' and '#{b}')
      run_sql.execute sql
    end

    if true #06 計算上班前中後，需扣除的休息時間
    	tmp06 = 'tmp06'
			tmpfiles = tmpfiles << tmp06
    	run_sql.execute("drop table if exists #{tmp06}")
    	sql = %Q(create table #{tmp06} as
				select a.employee_id,a.worktype_id,a.type
				,type_start,type_end 
				,sum(time_to_sec(-timediff(case when type_start between rest_st and rest_end then type_start else rest_st end 
				,case when type_end between rest_st and rest_end then type_end else rest_end end ))) rest_sec
				from tmp04 a
				inner join tmp05 b on a.worktype_id=b.worktype_id and a.is_holiday=b.is_holiday and a.type_start < b.rest_end and a.type_end > b.rest_st
				where is_deduct_for_duty=1
				 group by employee_id,a.type
				;)
      run_sql.execute sql
    end

    if true #07 
      tmp07 = 'tmp07'
      tmpfiles = tmpfiles << tmp07
      run_sql.execute("drop table if exists #{tmp07}") 
      run_sql.execute("create table #{tmp07} select * from daily_duties limit 0")
      run_sql.execute("insert into #{tmp07}
				(cardno,ou_id,employee_id,duty_date,worktype_id,is_holiday,std_on,std_off ,real_on,real_off,created_at,updated_at)
				select 
				cardno,ou_id,employee_id,duty_date,worktype_id,is_holiday,std_on,std_off ,real_on,real_off,now(),now()
				from tmp_duty
				;")
    end

    if true # 將資料轉入 daily_duties
    	run_sql.execute("Delete from daily_duties where ou_id='#{ou_id}' and duty_date='#{duty_date}'")
    	run_sql.execute("Insert into daily_duties select * from #{tmp07}")
    end

    if Rails.env=='production' # drop tmp table
    	tmpfiles.each do |i|
    		run_sql.execute("drop table if exists #{i}")
    	end
    end



	end
end
