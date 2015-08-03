 DROP PROCEDURE if exists P_D04;
 
 DELIMITER $$
 
CREATE PROCEDURE `P_D04` (
in_ou_id int,
in_duty_date date  
)

BEGIN 


DECLARE yesterday,nextday date ;

set yesterday = in_duty_date - interval 1 day;
set nextday = in_duty_date + interval 2 day;

DROP TABLE IF EXISTS tmp_daily_duties;
CREATE /*TEMPORARY*/ TABLE tmp_daily_duties SELECT * FROM daily_duties LIMIT 0;
ALTER TABLE tmp_daily_duties
  ADD INDEX i01 (employee_id,duty_date)
  ,DROP COLUMN ID;


# 產生應該有出勤的人員
  DROP TABLE IF EXISTS TMP01;
  
  CREATE TABLE IF NOT EXISTS TMP01  
  select  a.employee_id,a.duty_date,a.std_on,a.std_off,a.cardno,a.worktype_id
  , std_on - interval a.range_on  minute  range_A 
  ,std_off + interval a.range_off  minute range_B
  from view_sch_emps a
  where ou_id = in_ou_id and duty_date = in_duty_date;
  
  alter table tmp01 add index i01 (employee_id);
# 取得需要使用的 cardtimes

  DROP TABLE IF EXISTS tmp_cardtimes;
  
  CREATE TABLE IF NOT EXISTS tmp_cardtimes
  SELECT cardno,dtime
  FROM cardtimes a
  WHERE a.ou_id = in_ou_id and a.dtime between yesterday and nextday;
  
  alter table tmp_cardtimes add index i01 (cardno);

# 計算上下班時間
  DROP TABLE IF EXISTS tmp_duty;
  CREATE TABLE IF NOT EXISTS tmp_duty
  SELECT a.*
  ,substring(min(dtime),1,16) realon
  ,substring(max(dtime),1,16) realoff
  FROM tmp01 a
  left join tmp_cardtimes b on a.cardno=b.cardno and b.dtime between a.range_a and a.range_b
  GROUP BY a.employee_id;
  


END
$$

DELIMITER ;

