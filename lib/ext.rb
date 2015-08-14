class String
	def column_names # 用來取的table的column_names
		begin
		c = ActiveRecord::Base.connection
		d = c.columns(self)
		d.map(&:name)
	  rescue
	    return "no #{self} table"
    end
	end
end

class Array 
  # find_dups 抓出Array 重複的值，產出Array
  def find_dups 
  	uniq.map {|v| (self - [v]).size < (self.size - 1) ? v : nil}.compact
  end
end

module ActiveRecord
	class Base
		# def self.f1_create(attributes = nil,bat_size=200)
		# 	columns = attributes[0].keys 
		# 	col_size = columns.size
	 #    conn = ActiveRecord::Base.connection
		# 	values,rows = [],[]
		# 	attributes.each_with_index do |h,i|
		# 		h.each do |k,v| 
		# 			case v
		# 				when ActiveSupport::TimeWithZone then v = "'#{v.to_s(:db)}'"
		# 				when nil then v = 'NULL'
		# 				else v = "'#{v}'"
		# 			end 
		# 	    values[i] << v
		# 	  end 
		# 	end
		# 	return values.join(',')
	 #    if rows.size > 0
		# 	  # sql = "INSERT INTO #{table_name} (#{columns.join(',')}) VALUES (#{rows.join(',').chop.chop}"
		# 	  return values
		# 		# conn.execute(sql)
		# 	end
		# end
	end
end


Regexp_yyyymmdd = /\A([0-9]{4})-?(0[1-9]|1[0-2])-?(0[1-9]|1[0-9]|2[0-9]|3[0-1])\z/

Regexp_yyyymm = /\A([0-9]{4})-?(0[1-9]|1[0-2])\z/

Regexp_HHMM = /\A([0-1][0-9]|2[0-3]):?([0-5][0-9])\z/


