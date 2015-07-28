select a.employee_id,a.duty_date,b.offtype_id 
,if(b.offduty_begin_at < a.std_on , a.std_on , b.offduty_begin_at ) off_begin
,if(a.std_off < b.offduty_end_at , a.std_off,b.offduty_end_at) off_end
,offduty_begin_at,offduty_end_at,std_off 
from view_sch_emps a
inner join doc_offworks b on a.employee_id=b.employee_id and a.std_on < b.offduty_end_at and a.std_off > b.offduty_begin_at
where uid='a00514'