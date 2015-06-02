rails g scaffold offtype \
 uid name \
 mins_of_minimum:integer\
 mins_per_unit:integer\
 deduct_percent:integer\
 include_holiday:boolean\
 can_duplicate:boolean\
 is_quota_ctrl:boolean\
 is_stoped:boolean\
 memo:text\
 ou_id:integer\
 --force