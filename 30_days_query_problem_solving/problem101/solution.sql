with recursive cte as (
select min(sls_dt) as cnt from sls_tbl
union
select cnt  + interval 7 day
from cte
where cnt < (select max(sls_dt) from sls_tbl))
select cnt
from cte as c1 
left join sls_tbl as s
on c1.cnt = s.sls_dt
where s.sls_dt is null