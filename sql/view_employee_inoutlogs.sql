create or replace view view_employee_inoutlogs as
Select a.*,b.value
,c.uid emp_id,c.name emp_name 
,d.uid dept_id,d.name dept_name
from employee_inoutlogs a
left join options b on a.action=b.key and b.model_title='EmployeeInoutlog' and b.column_title='action'
left join employees c on c.id=a.employee_id
left join departments d on d.id=c.department_id; 