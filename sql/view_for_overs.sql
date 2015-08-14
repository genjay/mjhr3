create or replace view view_for_overs as
Select a.ou_id,a.employee_id,a.duty_date,std_off overwork_begin_at,real_off overwork_end_at
		  ,c.overtype_id 
          ,workC,delay_used,restC
		  ,floor((workC-delay_used-restC)/60) hr
			from daily_duties a
			left join worktypes b on a.worktype_id=b.id 
            left join employees c on c.id=a.employee_id
			where 
			(workC - delay_used-restC) > minimum_after_overwork;
             