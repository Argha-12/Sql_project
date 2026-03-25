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


------------- find the emp how have order 2 or more then two?
	select * from orders
select * from customers

select customer_id
from (
		select * ,
			row_number () over (partition by customer_id order by order_id) as rowss
		from orders
	) t
where rowss >= 2

select customer_id 
from orders
group by customer_id
having count(customer_id) >=2

select customer_id 
from orders
group by customer_id
having count(*) >=2

SELECT customer_id 
FROM orders
GROUP BY customer_id;


SELECT order_date, COUNT(*) AS total_orders
FROM orders
GROUP BY order_date;

--- find the user how consecutive 3 login days
select * from user_logins

with cte as (
	select * ,
		row_number() over (partition by user_id order by login_date ) as rn
	from user_logins
),
grp as (
	select *,
	dateadd(day, -rn , login_date) as grp_date
	from cte
)
select  user_id
from grp
group by user_id, grp_date
having count(*) >= 3

-----cutomers above their avg order value

select * from orders

SELECT *
FROM orders o
WHERE amount > (
        SELECT AVG(amount)
        FROM orders
        WHERE customer_id = o.customer_id ( the resion using this line group the values)
);
--------------------------------------------------------------------
WITH cte AS (
    SELECT *,
           AVG(amount) OVER (PARTITION BY customer_id) AS avg_amount
    FROM orders
)
SELECT *
FROM cte
WHERE amount > avg_amount;

-------find the customer who never orders
use test
select * from orders
select * from customers


select c.customer_id
from customers c
left join orders o
on c.customer_id = o.customer_id 
where o.customer_id is null

----top product per category
use test
select * from products
select * from sales

with cte as (
	select product_name ,
		amount = price * quantity
	from products p
	join sales s
	on p .product_id = s.product_id
),

ranks as (
	select * ,
	 row_number () over (partition by product_name order by amount) as rn
	from cte
)

select * 
from ranks
where rn = 1


