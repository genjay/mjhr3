run_duty = '20150701'

end_duty = '20150731'

st = Time.now
(run_duty..end_duty).each do |i|
	# DailyDuty.d04(1,i)
	DailyDuty.d04(1,i,'sid')
	# puts i
end

puts Time.now - st