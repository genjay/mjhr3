class DailyDuty < ActiveRecord::Base
	belongs_to :employee
	scope :open_duty, -> (ou_id,date) {where("is_closed= 0 and ou_id=? and duty_date=?",ou_id, date)}

	def self.d04(ou_id,duty_date,*sid) # 日結，duty_date 可以接受 range
		if duty_date.class == Range
			duty_date.each do |i|
				self.d04_by_duty(ou_id,i,*sid)
			end
		else
			self.d04_by_duty(ou_id,duty_date,*sid)
		end
	end

	def self.d04_by_duty(ou_id,duty_date,*sid) # 日結
		duty_date = duty_date.to_s
    conn = ActiveRecord::Base.connection  
    sid[0] ||= ''
    if true # 01 用 view_sch_emps，產生 => tmp01
    	tmp01 = "tmp01" << sid[0]
    	conn.execute "drop table if exists #{tmp01}"
    	conn.execute "create table #{tmp01} select * from view_sch_emps WHERE ou_id='#{ou_id}' and duty_date='#{duty_date}'"
			conn.execute("alter table #{tmp01} add index i01 (employee_id)")
    	tmp_base = tmp01
    end

    if true # 02 計算出上下班時間，結果=> tmp02
			if true # 02-a 計算取得(出勤日)前一日~後二日的刷卡資料
				a = 1.days.ago(duty_date.to_date)
				b = 2.days.since(duty_date.to_date)
	      tmp_cardtimes = 'tmp_cardtimes' << sid[0]
				conn.execute("drop table if exists #{tmp_cardtimes}")
				sql = %Q(create table #{tmp_cardtimes}
				Select id,up_data,created_at,updated_at,ou_id,cardno,concat(substring(dtime,1,16),':00') dtime
				from cardtimes
				where dtime between '#{a}' and '#{b}')
				conn.execute(sql)
				conn.execute("alter table #{tmp_cardtimes} add index i01 (cardno,dtime)")
			end
	    if true # 02-b 計算上下班時間
	    	tmp02 = 'tmp02' << sid[0]
	    	conn.execute("drop table if exists #{tmp02}")
	    	sql = %Q(create table #{tmp02} 
	    		select a.*,min(dtime) real_on,max(dtime) real_off
					,case when min(dtime) < std_on then min(dtime) else std_on end aa
					,case when max(dtime) > std_off then max(dtime) else std_off end bb
					from #{tmp_base} a
					left join #{tmp_cardtimes} b on a.cardno=b.cardno and b.dtime between a.range_on and a.range_off
					group by a.employee_id;)
	    	conn.execute sql
	    end
	    if true # 刪除無用的 tmp01 tmp_cardtimes 
	    	conn.execute "drop table if exists #{tmp01}"
	    	conn.execute "drop table if exists #{tmp_cardtimes}" 
	    	tmp_base = tmp02 
	    end
    end

    if true # 03 計算上班，的前中後
	    if true # 03-a 依 tmp_base 加上，上班 前中後起迄 
	    	tmp03a = 'tmp03a' << sid[0]
	    	conn.execute("drop table if exists #{tmp03a}")
	    	sql = "create table #{tmp03a}
	    		select employee_id,worktype_id,is_holiday,'working' type
					,case when std_on > real_on then std_on else real_on end type_start
					,case when real_off > std_off then std_off else real_off end type_end
					from #{tmp_base} union all
					select employee_id,worktype_id,is_holiday,'before' type,aa,std_on
					from #{tmp_base} union all
					select employee_id,worktype_id,is_holiday,'after' type,std_off,bb
					from #{tmp_base} " 
	    	conn.execute(sql) 
	    end
      if true # 03-b 產生需要的休息時刻表 
      	tmp03b = 'tmp03b' << sid[0]
  			a = 1.days.ago(duty_date.to_date)
  			b = 2.days.since(duty_date.to_date)
      	conn.execute("drop table if exists #{tmp03b}")
      	sql = %Q(create table #{tmp03b}
      		select * 
      		from view_workrests 
      		where ou_id = #{ou_id} and duty_date between '#{a}' and '#{b}')
        conn.execute sql
      end
      if true # 03-c 
	    	tmp03c = 'tmp03c' << sid[0]
	    	conn.execute("drop table if exists #{tmp03c}")
	    	sql = %Q(create table #{tmp03c} as
					select a.employee_id,a.worktype_id,a.type
					,type_start,type_end 
					,time_to_sec(timediff(type_end,type_start)) work_sec
					,(sum(is_deduct_for_duty*time_to_sec(-timediff(case when type_start between rest_st and rest_end then type_start else rest_st end 
					,case when type_end between rest_st and rest_end then type_end else rest_end end )))) rest_sec
					from #{tmp03a} a
					left join #{tmp03b} b on a.worktype_id=b.worktype_id and a.is_holiday=b.is_holiday and a.type_start < b.rest_end and a.type_end > b.rest_st
					where 1=1
					 group by employee_id,a.type
					;)
	      conn.execute sql
      end

      if true # 03-d
	      tmp03d = 'tmp03d' << sid[0]
	      conn.execute "drop table if exists #{tmp03d}"
	      sql = %Q(create table #{tmp03d} select a.employee_id
					,floor(sum(case when type='before' then work_sec else 0 end)/60) workA
					,floor(sum(case when type='working' then work_sec else 0 end)/60) workB
					,floor(sum(case when type='after' then work_sec else 0 end)/60) workC
					,floor(sum(case when type='before' then rest_sec else 0 end)/60) restA
					,floor(sum(case when type='working' then rest_sec else 0 end)/60) restB
					,floor(sum(case when type='after' then rest_sec else 0 end)/60) restC
					from #{tmp03c} a
					group by employee_id;)
	 			conn.execute sql
      end
      if true
      	tmp03 = 'tmp03' << sid[0]
      	now = Time.now.utc.to_s[0,19]
      	conn.execute "drop table if exists #{tmp03}"
      	sql = %Q(create table #{tmp03} 
      		Select a.*,b.workA,b.workB,b.workC,b.restA,b.restB,b.restC
      		,case 
					 when time_to_sec(timediff(real_on,std_on))/60 > 0 && time_to_sec(timediff(real_on,std_on))/60 < buffer_after_duty  then time_to_sec(timediff(real_on,std_on))/60
					 else 0 end delay_used
      		,'#{now}' created_at,'#{now}' updated_at
					from #{tmp02} a
					left join #{tmp03d} b on a.employee_id=b.employee_id)
        conn.execute sql
        tmp_base = tmp03
        if true 
	        conn.execute "drop table if exists #{tmp02}"
	        conn.execute "drop table if exists #{tmp03a}"
	        conn.execute "drop table if exists #{tmp03b}"
	        conn.execute "drop table if exists #{tmp03c}"
	        conn.execute "drop table if exists #{tmp03d}"
      	end
      end
    end

    if nil # 04 將 doc_overworks 併入 
    	# 20150827 改成加班單不需結轉
    	tmp04 = 'tmp04' << sid[0]
    	conn.execute "drop table if exists #{tmp04}"
    	sql = "create table #{tmp04} as
	    	select a.*
	    	,sum(b.mins_A) over_a,sum(b.mins_B) over_b,sum(b.mins_C) over_c,sum(b.mins_H) over_h
	    	from #{tmp03} a
	    	left join doc_overworks b on a.employee_id=b.employee_id and a.duty_date=b.duty_date
	    	group by a.employee_id,a.duty_date;"
	    conn.execute sql
	    tmp_base = tmp04
	    conn.execute "drop table if exists #{tmp03}"
    end

    if true # 將最後結果新增到 daily_duties
    	DailyDuty.open_duty(ou_id,duty_date).delete_all
    	arr_c = (tmp_base.column_names & DailyDuty.column_names)
    	arr_c.delete('id')
    	columns = arr_c.join(',')
    	sql = "INSERT INTO daily_duties (#{columns}) SELECT #{columns} FROM #{tmp_base}"
    	conn.execute sql
    	return DailyDuty.open_duty(ou_id,duty_date).count
    end

    if true # 清除所有 tmp開頭的 tables
    	conn.tables.each do |i|
    		if i[0,3] == 'tmp' && i.match(sid[0])
    			conn.execute "Drop table if exists #{i}"
    		end
    	end
    end
  end
end

