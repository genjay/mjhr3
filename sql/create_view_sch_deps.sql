create or replace view view_sch_deps as
Select 
 ifnull(c.id,0) id,
 a.id department_id,
 a.ou_id,a.uid,a.name
,b.duty_date
,case
 when c.worktype_id is not null then c.worktype_id
 else a.worktype_id
 end worktype_id
,case 
 when c.is_holiday is not null then c.is_holiday 
 else b.is_holiday
 end is_holiday
from departments a
left join calendars b on a.ou_id=b.ou_id
left join sch_deps c on c.department_id=a.id 
  and c.duty_date=b.duty_date