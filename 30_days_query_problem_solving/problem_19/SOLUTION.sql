---this solution for mysql
SELECT 
    DATE_FORMAT(order_time, '%M %y') AS no_month,
    ROUND(SUM(CASE 
        WHEN TIMESTAMPDIFF(MINUTE, order_time, actual_delivery) > 30 THEN 1 
        ELSE 0 
    END) / COUNT(1) * 100, 1) AS delayed_flag,
    SUM(CASE 
        WHEN TIMESTAMPDIFF(MINUTE, order_time, actual_delivery) > 30 THEN no_of_pizzas
        ELSE 0 
    END) AS free_pizzas
FROM pizza_delivery
WHERE actual_delivery IS NOT NULL
GROUP BY DATE_FORMAT(order_time, '%M %y')




-- CORRECTED Solution:
---this solution for postgresql

select to_char(order_time, 'Mon-YYYY') as period
, concat(round((cast(sum(case when extract(hour from (actual_delivery - order_time))*60 
			+ extract(minute from (actual_delivery - order_time)) 
			> 30 then 1 else 0 end)	as decimal) / count(1))*100,1),'%')  delayed_flag	
, sum(case when extract(hour from (actual_delivery - order_time))*60 
			+ extract(minute from (actual_delivery - order_time)) 
			> 30 then no_of_pizzas else 0 end)	 as free_pizzas		
from pizza_delivery
where actual_delivery is not null
group by to_char(order_time, 'Mon-YYYY')
order by extract(month from to_date(to_char(order_time, 'Mon-YYYY'),'Mon-YYYY'));



/*
-- Incorrect solution since it did not handle orders which were delayed by more than or equal to 60 mins. 
select to_char(order_time,'Mon-YYYY') as period
, concat(round((cast(sum(case when cast(to_char(actual_delivery-order_time,'MI') as int) > 30 
			then 1 else 0 end) as decimal)
	/count(1))*100,1),'%')	as delayed_order_perc
, sum(case when cast(to_char(actual_delivery-order_time,'MI') as int) > 30 
			then no_of_pizzas else 0 end) as free_pizzas
from pizza_delivery
where actual_delivery is not null
group by to_char(order_time,'Mon-YYYY') 
order by extract(month from to_date(to_char(order_time,'Mon-YYYY'), 'Mon-YYYY'))
*/