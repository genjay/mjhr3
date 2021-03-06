create or replace view view_sch_emps as
Select ifnull(c.id,0) id
,a.id employee_id
,a.ou_id,a.uid,a.name,b.duty_date
,case 
 when c.worktype_id is not null then c.worktype_id
 when d.worktype_id is not null then d.worktype_id
 else e.worktype_id
 end worktype_id
,case 
 when c.is_holiday is not null then c.is_holiday
 when d.is_holiday is not null then d.is_holiday
 else b.is_holiday
 end is_holiday
 ,case 
 when c.worktype_id is not null then 'sch_emps'
 when d.worktype_id is not null then 'sch_deps'
 else 'departments'
 end notes
,e.id department_id
,w.mins_of_duty
,str_to_date(concat(b.duty_date,w.on_duty_at),'%Y-%m-%d%H:%i:%s')
 + interval w.on_duty_offset day - interval w.range_on minute range_on
,str_to_date(concat(b.duty_date,w.off_duty_at),'%Y-%m-%d%H:%i:%s')
 + interval w.off_duty_offset day + interval w.range_off minute range_off 
-- ,w.range_on,w.range_off
,w.on_duty_at,w.off_duty_at
,str_to_date(concat(b.duty_date,w.on_duty_at),'%Y-%m-%d%H:%i:%s')
 + interval w.on_duty_offset day std_on
,str_to_date(concat(b.duty_date,w.off_duty_at),'%Y-%m-%d%H:%i:%s')
 + interval w.off_duty_offset day std_off 
,a.cardno
,w.buffer_before_duty,w.buffer_after_duty
from employees a
left join calendars b on a.ou_id=b.ou_id 
  and b.duty_date >= a.arrive_date
  and b.duty_date <= ifnull(a.leave_date,'99991231')
left join sch_emps c on a.id=c.employee_id and c.duty_date=b.duty_date
left join sch_deps d on d.department_id=a.department_id and d.duty_date=b.duty_date
left join departments e on e.id=a.department_id
left join worktypes w on w.id = case 
 when c.worktype_id is not null then c.worktype_id
 when d.worktype_id is not null then d.worktype_id
 else e.worktype_id end 