-- Solution using CROSSTAB in PostgreSQL 
SELECT 
    velocity,
    SUM(CASE WHEN level = 'good' THEN count ELSE 0 END) AS good,
    SUM(CASE WHEN level = 'wrong' THEN count ELSE 0 END) AS wrong,
    SUM(CASE WHEN level = 'regular' THEN count ELSE 0 END) AS regular
FROM 
    (
        SELECT v.value AS velocity, l.value AS level, COUNT(1) AS count
        FROM auto_repair l
        JOIN auto_repair v ON v.auto = l.auto AND v.repair_date = l.repair_date AND l.client = v.client
        WHERE l.indicator = 'level'
        AND v.indicator = 'velocity'
        GROUP BY v.value, l.value
    ) bq
GROUP BY 
    velocity;


-- Solution using PIVOT in Micrososft SQLServer
select *
from 
    (
        select v.value velocity, l.value level,count(1) as count
        from auto_repair l
        join auto_repair v on v.auto=l.auto and v.repair_date=l.repair_date and l.client=v.client
        where l.indicator='level'
        and v.indicator='velocity'
        group by v.value,l.value
    ) bq
pivot 
    (
        count(level)
        for level in ([good],[wrong],[regular])
    ) pq;

