create or replace view view_salary_base as
select employee_id
,sum(case when b.overwork_base=1 then amt else 0 end)/240 over_base
,sum(case when b.offwork_base=1 then amt else 0 end)/240 off_base 
from employee_salary_settings a
left join pay_types b on a.pay_type_id=b.id  
group by employee_id
;