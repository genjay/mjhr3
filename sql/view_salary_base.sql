create or replace view view_salary_base as
select employee_id
,sum(case when b.overwork_base=1 then amt else 0 end
 /case 
  when cycle_unit = 'A' then c.days_per_month*c.hours_per_day
  when cycle_unit = 'B' then c.hours_per_day
  when cycle_unit = 'C' then 1
  end) over_per_hr
,sum(case when b.offwork_base=1 then amt else 0 end
 /case 
  when cycle_unit = 'A' then c.days_per_month*c.hours_per_day
  when cycle_unit = 'B' then c.hours_per_day
  when cycle_unit = 'C' then 1
  end) off_per_hr
from employee_salary_settings a
left join pay_types b on a.pay_type_id=b.id  
left join ous c on c.id=a.ou_id
group by employee_id
;