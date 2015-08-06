st = Time.now
# Department.pluck(:id).each do |i|
#   Department.reset_counters(i, :employees)
# end
w = Worktype.where("name not like ?",'%園區%')
Workrest.where(worktype_id: w.ids).delete_all
w.each do |i| 
	if true # 平日
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '00:00:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 0)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '03:00:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 0)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '07:00:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 0)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '10:20:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 0)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '12:30:00',mins_of_rest: 40,is_deduct_for_duty: 1,is_holiday: 0)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '15:10:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 0)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '17:20:00',mins_of_rest: 20,is_deduct_for_duty: 1,is_holiday: 0)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '19:50:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 0)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '21:50:00',mins_of_rest: 15,is_deduct_for_duty: 0,is_holiday: 0)
	end
	if true #假日
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '00:00:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 1)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '03:00:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 1)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '07:00:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 1)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '10:20:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 1)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '12:30:00',mins_of_rest: 40,is_deduct_for_duty: 1,is_holiday: 1)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '15:10:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 1)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '17:20:00',mins_of_rest: 20,is_deduct_for_duty: 1,is_holiday: 1)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '19:50:00',mins_of_rest: 10,is_deduct_for_duty: 0,is_holiday: 1)
		i.workrests.create(ou_id:i.ou_id,rest_begin_at: '21:50:00',mins_of_rest: 15,is_deduct_for_duty: 0,is_holiday: 1)
	end
end

puts Time.now - st
