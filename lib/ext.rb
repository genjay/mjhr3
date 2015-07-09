class Array 
  # find_dups 抓出Array 重複的值，產出Array
  def find_dups 
  	uniq.map {|v| (self - [v]).size < (self.size - 1) ? v : nil}.compact
  end

end
