--- find emp who earn more then avaerage salary of all emp ------

---with CTE ---
select * from emp_new;
with average_salary (avg_sal) as
	(select avg(salary) from emp_new)
select emp_name , salary
from emp_new E , average_salary
where E.salary > average_salary.avg_sal;
    
---with out CTE(subquery)---
select emp_name , salary
from emp_new 
where salary > 	(select avg(salary) from emp_new);
