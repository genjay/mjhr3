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



