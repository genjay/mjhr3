class Option < ActiveRecord::Base
	# 為何沒用STI ，STI 是接model的物件，這裡只是 model內某欄位用的 下拉選項
	# 試過了，好象沒比較簡單
	validates :key, :value, :model_title, :column_title, presence: true

	def self.of(model,column)
		Option.select(:key,:value).where(model_title: model,column_title: column).map do |i|
			[i.to_s,i.key]
		end
	end
	
	def to_s
		"#{key} #{value}"
	end
end
