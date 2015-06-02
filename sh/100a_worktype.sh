rails g scaffold worktype \
 uid name\
 on_duty_at:time\
 off_duty_at:time\
 buffer_before_duty:integer \
 buffer_after_duty:integer \
 minimum_before_overwork:integer \
 minimum_after_overwork:integer\
 minimum_holiday_overwork:integer\
 range_on:integer\
 range_off:integer\
 is_stoped:boolean\
 mins_of_duty:integer\
 memo:text\
 ou_id:integer\
 --force