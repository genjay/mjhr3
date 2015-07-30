 DROP PROCEDURE P_D04;
 
 DELIMITER $$
 
CREATE PROCEDURE `P_D04` (
in_ou_id int,
in_duty_date date 
)

BEGIN
  DROP TABLE IF EXISTS TMP01;
  CREATE TABLE TMP01 LIKE DAILY_DUTIES;
  
  Insert into TMP01 
  (employee_id,duty_date,ou_id,is_holiday,worktype_id,created_at,updated_at) 
  select 
  employee_id,duty_date,ou_id,is_holiday,worktype_id,utc_timestamp,utc_timestamp 
  from view_sch_emps 
  where ou_id = in_ou_id and duty_date = in_duty_date;
  
END
$$

DELIMITER ;

