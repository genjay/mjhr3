st = Time.now
Department.pluck(:id).each do |i|
  Department.reset_counters(i, :employees)
end

puts Time.now - st
