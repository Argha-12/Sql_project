use HR

select * from employees

----Find the highest salary in each department

select department, max(salary) as highest_salary
from employees
group by department


----Find employees who earn more than their manager

select e.emp_id as emp_id,
	   e.emp_name as emp_name,
	   m.manager_id as manager_id,
	   e.salary as emp_salary,
	   m.emp_name as manager_name,
	   m.salary as manager_salary
from employees e
join employees m
on e.manager_id = m.emp_id

select 
    e.emp_id,
    e.emp_name,
    e.salary as employee_salary,
    m.emp_name as manager_name,
    m.salary as manager_salary,
    m.manager_id
from employees e
join employees m
    on e.manager_id = m.emp_id
where e.salary > m.salary;


----Find the second highest salary overall


with cte as (
     select emp_name,
            salary,
     dense_rank() over ( order by salary desc) as salary_rank
     from employees
)

select *
from cte 
where salary_rank = 2


---List employees hired in the last 3 years

select
    emp_name,
    year(hire_date) as years
from employees
where year(hire_date) between 2017 and 2020

--or

select
    emp_name,
    hire_date
from employees
where hire_date >= dateadd(year, -3, getdate());


----Find departments with more than 2 employees

select 
    department,
    count(emp_name) as counts
from employees
group by department
having count(emp_name) > 2


---Find employees who do not have a manager
select * from employees

select 
    emp_name
from employees 
where manager_id is null

---Calculate average salary per department

select 
    e.emp_id,
    e.emp_name,
    e.department,
    e.salary
from employees e
where e.salary >
      (
          select avg(salary)
          from employees
          where department = e.department
      );


