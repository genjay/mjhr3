class MonthDuty < ActiveRecord::Base

  def self.d04(ou_id ,yyyymm ,duty_fr ,duty_to,*sid)
  	conn = ActiveRecord::Base.connection
    duty_fr = duty_fr.to_s.delete '-'
    duty_to = duty_to.to_s.delete '-'

    if true # 出勤及加班月結
    	tmp01 = 'tmp01' 
      range_days = (duty_to.to_s.to_date - duty_fr.to_s.to_date) + 1
    	conn.execute "drop table if exists #{tmp01}"
    	sql =  "create table #{tmp01} as
                Select #{yyyymm} yyyymm,#{duty_fr} duty_fr,#{duty_to} duty_to
                ,a.ou_id,a.employee_id,sum(1) dutydays
                ,sum(over_a) over_a
                ,sum(over_b) over_b
                ,sum(over_c) over_c
                ,sum(over_h) over_h
                ,#{range_days} range_days
                from daily_duties a
                left join doc_overworks b on a.ou_id=b.ou_id and a.duty_date=b.duty_date and a.employee_id=b.employee_id
                where a.ou_id = #{ou_id}
                and a.duty_date between '#{duty_fr}' and '#{duty_to}'
                group by a.employee_id" 
      conn.execute sql
      tmp_base = tmp01
    end

    if true # 請假的月結
      tmp02 = 'tmp02'
      conn.execute "drop table if exists #{tmp02}"
      sql = "create table #{tmp02} as
      select #{ou_id} ou_id,#{yyyymm} yyyymm,b.employee_id,b.offtype_id,sum(a.mins_of_duty) mins_of_duty,deduct_percent
      from daily_offworks a
      left join doc_offworks b on b.id=a.doc_offwork_id
      left join daily_duties c on c.duty_date=a.duty_date and c.employee_id=b.employee_id
      left join offtypes d on d.id=offtype_id
      group by employee_id,offtype_id
      ;"
      conn.execute sql
    end

    if true # 將最後結果新增到 month_duties
    	MonthDuty.where("ou_id=#{ou_id} and yyyymm=#{yyyymm}").delete_all
    	arr_c = (tmp_base.column_names & MonthDuty.column_names)
    	arr_c.delete('id')
    	columns = arr_c.join(',')
      now = Time.now.utc.to_s(:db)
    	sql = "INSERT INTO month_duties (#{columns},created_at,updated_at) SELECT #{columns},'#{now}','#{now}' FROM #{tmp_base}"
    	conn.execute sql
    	 MonthDuty.where("ou_id=#{ou_id} and yyyymm=#{yyyymm}").count
    end

    if true # 將tmp02結果新增至 month_offworks
      tmp_base = tmp02
      MonthOffwork.where("ou_id='#{ou_id}' and yyyymm='#{yyyymm}'").delete_all
      arr_c = (tmp_base.column_names & MonthOffwork.column_names)
      arr_c.delete 'id'
      columns = arr_c.join ','
      now = Time.now.utc.to_s :db
      sql = "INSERT INTO month_offworks (#{columns},created_at,updated_at) SELECT #{columns},'#{now}','#{now}' FROM #{tmp_base}"
      conn.execute sql
    end

    if nil # 清除所有 tmp開頭的 tables
    	conn.tables.each do |i|
    		if i[0,3] == 'tmp' && i.match(sid[0])
    			conn.execute "Drop table if exists #{i}"
    		end
    	end
    end
  end
end
