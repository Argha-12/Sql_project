-- PostgreSQL
with cte as 
	(select p.*
	, extract('epoch' from (session_endtime - session_starttime)) as total_seconds
	from user_sessions s
	join post_views p on p.session_id=s.session_id)
select post_id
, sum(round(cast((perc_viewed/100)*total_seconds as decimal),1)) as total_viewtime
from cte 
group by post_id
having sum(round(cast((perc_viewed/100)*total_seconds as decimal),1)) > 5;



-- Micrososft SQL Server
with cte as 
	(select p.*
	, datediff(s,session_starttime,session_endtime) as total_seconds
	from user_sessions s
	join post_views p on p.session_id=s.session_id)
select post_id
, sum(round((perc_viewed/100)*total_seconds,1)) as total_viewtime
from cte 
group by post_id
having sum(round((perc_viewed/100)*total_seconds,1)) > 5;

--mysql

with cte as(
	select  p.* , u.session_starttime , u.session_endtime,post_id,
	TIMESTAMPDIFF(SECOND,session_starttime , session_endtime) total_time
	from user_sessions u
	join post_views p 
	on u.session_id = p.session_id
)
select post_id,
sum((perc_viewed/100)*total_time) as view_time
from cte
group by post_id
having sum((perc_viewed/100)*total_time) > 5

