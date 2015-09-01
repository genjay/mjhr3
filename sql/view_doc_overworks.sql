create or replace view view_doc_overworks as
# 用doc_overworks來計算加班費amt_A...
select a.id,a.employee_id,a.duty_date 
,round(a.mins_A/60*b.rate_of_A*over_per_hr) amt_A
,round(a.mins_B/60*b.rate_of_B*over_per_hr) amt_B
,round(a.mins_C/60*b.rate_of_C*over_per_hr) amt_C
,round(a.mins_H/60*b.rate_of_H*over_per_hr) amt_H
from doc_overworks a
left join overtypes b on b.id=a.overtype_id and b.pay_type='A' 
left join view_salary_base c on a.employee_id=c.employee_id
; 
 