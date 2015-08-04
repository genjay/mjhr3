create or replace view view_workrests as
Select a.ou_id,a.duty_date
,b.worktype_id,b.is_holiday,b.is_deduct_for_duty
,str_to_date(concat(a.duty_date,' ',b.rest_begin_at),'%Y-%m-%d %H:%i:%s') rest_st
,str_to_date(concat(a.duty_date,' ',b.rest_begin_at),'%Y-%m-%d %H:%i:%s') 
 + interval mins_of_rest minute rest_end
,b.rest_begin_at,b.mins_of_rest
from calendars a
left join workrests b on b.ou_id=a.ou_id  