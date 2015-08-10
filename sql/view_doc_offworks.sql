
Select a.employee_id,b.duty_date
,case when offduty_begin_at > b.std_on then offduty_begin_at else b.std_on end offduty_on
,case when offduty_end_at < b.std_off then offduty_end_at else std_off end offduty_off
from doc_offworks a
left join daily_duties b on a.employee_id=b.employee_id 
 and offduty_begin_at < std_off and offduty_end_at > std_on;
 