class AddViewSchDepsViewSchEmps < ActiveRecord::Migration
  def up
  	self.connection.execute %Q(create or replace view view_sch_deps as
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
			  and c.duty_date=b.duty_date;)

  	self.connection.execute %Q(create or replace view view_sch_emps as
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
			from employees a
			left join calendars b on a.ou_id=b.ou_id 
			  and b.duty_date >= a.arrive_date
			  and b.duty_date <= ifnull(a.leave_date,'99991231')
			left join sch_emps c on a.id=c.employee_id and c.duty_date=b.duty_date
			left join sch_deps d on d.department_id=a.department_id and d.duty_date=b.duty_date
			left join departments e on e.id=a.department_id;)
  end
  def down
  	self.connection.execute "DROP VIEW view_sch_deps"
  	self.connection.execute "DROP VIEW view_sch_emps"
  end
end
