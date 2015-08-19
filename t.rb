run_duty = '20150701'

end_duty = '20150731'

st = Time.now
EmployeeSalarySetting.delete_all
Employee.all.each do |i|
	i.employee_salary_settings.create(ou_id: i.ou_id,pay_type: PayType.find_by(uid:'A'),amt: 28800)
	i.employee_salary_settings.create(ou_id: i.ou_id,pay_type: PayType.find_by(uid:'B'),amt: 1200)
end

puts Time.now - st