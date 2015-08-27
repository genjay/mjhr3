create view view_employee_inoutlogs as
Select a.*,b.value
from employee_inoutlogs a
left join options b on a.action=b.key and b.model_title='EmployeeInoutlog' and b.column_title='action';
 