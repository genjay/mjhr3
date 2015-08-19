class MonthSalary < ActiveRecord::Base
	def self.d04(ou_id,yyyymm,*sid)
		conn = ActiveRecord::Base.connection

		if true # 計算 rate_by_duty 依出勤日比率給付的所有薪資類別
			tmp01 = 'tmp01'
			conn.execute "drop table if exists #{tmp01}"
			sql = "create table #{tmp01} as
			SELECT a.ou_id,a.employee_id,a.yyyymm,b.pay_type_id
			,round(case 
			 when dutydays=range_days or dutydays>=30 then amt
			 else dutydays/30 * amt
			 end) amt 
			FROM month_duties a
			left join employee_salary_settings b on a.employee_id=b.employee_id 
			left join pay_types c on b.pay_type_id=c.id 
			where rule_for_break = 'rate_by_duty'
			and a.ou_id=#{ou_id}
			;"
			conn.execute sql
	  end

	  if true # 計算 pay_all 的薪資類別
	  	tmp02 = 'tmp02'
	  	conn.execute "drop table if exists #{tmp02}"
	  	sql = "create table #{tmp02} as 
	  	SELECT a.ou_id,a.employee_id,a.yyyymm,b.pay_type_id
	  	,amt
	  	FROM month_duties a
	  	left join employee_salary_settings b on a.employee_id=b.employee_id
	  	left join pay_types c on b.pay_type_id=c.id
	  	where rule_for_break = 'pay_all'
	  	and a.ou_id = #{ou_id};"
	  	conn.execute sql
	  end

	  if true # 將tmp01結果新增至 month_salaries
      tmp_base = tmp01
      MonthSalary.where("ou_id='#{ou_id}' and yyyymm='#{yyyymm}'").delete_all
      arr_c = (tmp_base.column_names & MonthSalary.column_names)
      arr_c.delete 'id'
      columns = arr_c.join ','
      now = Time.now.utc.to_s :db
      sql = "INSERT INTO month_salaries (#{columns},created_at,updated_at) SELECT #{columns},'#{now}','#{now}' FROM #{tmp_base}"
      conn.execute sql
    end

	  if true # 將tmp02結果新增至 month_salaries
      tmp_base = tmp02
      # MonthSalary.where("ou_id='#{ou_id}' and yyyymm='#{yyyymm}'").delete_all
      arr_c = (tmp_base.column_names & MonthSalary.column_names)
      arr_c.delete 'id'
      columns = arr_c.join ','
      now = Time.now.utc.to_s :db
      sql = "INSERT INTO month_salaries (#{columns},created_at,updated_at) SELECT #{columns},'#{now}','#{now}' FROM #{tmp_base}"
      conn.execute sql
    end

    if true # 取需要的 month_others 至 tmp03
    	tmp03 = 'tmp03'
	  	conn.execute "drop table if exists #{tmp03}"
	  	sql = "create table #{tmp03} as 
	  	SELECT a.ou_id,a.employee_id,a.yyyymm,a.pay_type_id,a.amt
	  	FROM month_others a 
	  	where a.ou_id = #{ou_id}
	  	and a.yyyymm = #{yyyymm};"
	  	conn.execute sql
    end

    if true # 將tmp03 結果新增至 month_salaries
      tmp_base = tmp03
      # MonthSalary.where("ou_id='#{ou_id}' and yyyymm='#{yyyymm}'").delete_all
      arr_c = (tmp_base.column_names & MonthSalary.column_names)
      arr_c.delete 'id'
      arr_c.delete 'created_at'
      arr_c.delete 'updated_at'
      columns = arr_c.join ','
      now = Time.now.utc.to_s :db
      sql = "INSERT INTO month_salaries (#{columns},created_at,updated_at) SELECT #{columns},'#{now}','#{now}' FROM #{tmp_base}"
      conn.execute sql
    end


	end
end
