


select salary , jobtitle,
 rank() over (order by salary ) as rank_total,
 Dense_rank() over (order by salary ) as Dense_rank_total,
 ROW_NUMBER() over (order by salary) as ROW_NUMBER_total,
 percent_rank() over (order by salary ) as percent_rank_total
 from employees;
