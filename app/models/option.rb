class Option < ActiveRecord::Base

	def self.of(model,column)
		Option.where(model_title: model,column_title: column).map do |i|
			[i.to_s,i.key]
		end
	end
	
	def to_s
		"#{key} #{value}"
	end
end
