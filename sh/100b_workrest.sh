rails g model workrest \
 worktype:references \
 is_holiday:boolean \
 rest_begin_at:time \
 mins_of_rest:integer \
 is_deduct_for_duty:boolean\
 memo:text\
 ou_id:integer\
 --force 