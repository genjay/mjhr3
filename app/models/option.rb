class Option
# 用來作下拉選單的選項，主要用在 使用者不能修改的選項
	class << self
		def sex
			x = %w(Man Woman)
		end

		def marriage
     			 x = %w(single married)
		end

		def education
      			x = %w(小學 國中 高中 五專 大學 碩士 博士)
		end
	end
end