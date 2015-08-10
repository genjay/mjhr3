class MonthDuty < ActiveRecord::Base
	
	def self.d04(ou_id ,yyyymm ,duty_fr ,duty_to,*sid)
		conn = ActiveRecord::Base.connection
		tmp01 = 'tmp01' 
		conn.execute "drop table if exists #{tmp01}"
		sql = %Q(create table #{tmp01} as
					Select #{yyyymm} yyyymm
					a.employee_id,sum(1) dutydays
					from daily_duties a
					where ou_id = #{ou_id}
					and duty_date between '#{duty_fr}' and '#{duty_to}'
					group by a.employee_id
					)
    conn.execute sql
    tmp_base = tmp01

    if true # 將最後結果新增到 daily_duties
    	MonthDuty.where("ou_id=#{ou_id} and yyyymm=#{yyyymm}").delete_all
    	arr_c = (tmp_base.column_names & MonthDuty.column_names)
    	arr_c.delete('id')
    	columns = arr_c.join(',')
    	sql = "INSERT INTO month_duties (#{columns}) SELECT #{columns} FROM #{tmp_base}"
    	conn.execute sql
    	return MonthDuty.where("ou_id=#{ou_id} and yyyymm=#{yyyymm}").count
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
