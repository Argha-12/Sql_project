-- just for windows function ----
--rank, Dense_rank, ROW_NUMBER, percent_rank,----

select salary , jobtitle,
 rank() over (order by salary ) as rank_total,
 Dense_rank() over (order by salary ) as Dense_rank_total,
 ROW_NUMBER() over (order by salary) as ROW_NUMBER_total,
 percent_rank() over (order by salary ) as percent_rank_total
 from employees;


---first_value, last_value, lead, lag ----

 select salary , jobtitle,
 first_value(salary) over (order by salary ) as first__value,
 last_value(salary) over (order by salary ) as last__value,
 lead(salary) over (order by salary) as lead_values,
 lag(salary) over (order by salary ) as lag_values
 from employees;


---fetch the first 2 emp how has join first---
select * from(
		select e.*,
		row_number() over(partition by jobtitle) as number_salary
		from employees e) x
where x.number_salary <2;

----fined the top 3 emp how has getting max salary each department-----
select * from(
		select e.*,
		rank() over(partition by jobtitle order by salary) as number_salary
		from employees e) x
where x.number_salary <4;

select e.*,
rank() over(partition by jobtitle order by salary) as number_salary
from employees e ;
