class Cardtime < ActiveRecord::Base
	require 'csv'

	def self.import(file,ou_id)
		# v = Set.new
		v = []
		i,cnt = 0,0 
	  CSV.foreach(file.path, headers: false) do |row|
			# Cardtime.create(up_data: row) 太慢 1秒 500筆
			# 改組成一個sql，1秒 1.5萬筆左右 
			i+=1
			arr = row[0].split('!') 
			cardno = arr[1]
			dtime = arr[2]
			v.<<("('#{dtime}','#{cardno}',#{ou_id},'#{row[0]}','#{Time.now.utc.to_s[0..18]}','#{Time.now.utc.to_s[0..18]}')")
			if i%100 == 0
				sql = "INSERT INTO cardtimes (dtime, cardno, ou_id, up_data, created_at, updated_at) VALUES #{v.join(", ")}"
			  run_sql = ActiveRecord::Base.connection
			  run_sql.execute(sql) 
			  cnt = cnt + v.size
			  v=[]
			end
	  end # end CSV.foreach
    if v.size > 0 
			cnt = cnt + v.size
			sql = "INSERT INTO cardtimes (dtime, cardno, ou_id, up_data, created_at, updated_at) VALUES #{v.join(", ")}"
		  run_sql = ActiveRecord::Base.connection
		  run_sql.execute(sql)
		end
	  return cnt
	end # end self.import(file)

		def self.f1_create(attributes = nil,bat_size=200)
			columns = attributes[0].keys 
	    conn = ActiveRecord::Base.connection
			values,rows = '',''
			attributes.each_with_index do |h,i|
				h.each do |k,v| 
					v = v.to_s(:db) if v.class == ActiveSupport::TimeWithZone
			  	values << "'#{v}',"
			  end
			  rows << "(#{values.chop}),"
			  values =''
			  if rows.size % bat_size == 0
					sql = "INSERT INTO #{table_name} (#{columns.join(',')}) VALUES #{rows.chop}"
			  	conn.execute sql
			  	rows =''
			  end
			end
	    if rows.size > 0
			  sql = "INSERT INTO #{table_name} (#{columns.join(',')}) VALUES #{rows.chop}"
				conn.execute(sql)
			end
		end

end
