## find the 2nd hight salary##

SELECT DEPT_NAME, SALARY 
FROM employee
WHERE SALARY = (
    SELECT MAX(SALARY)
    FROM employee
    WHERE SALARY < (
        SELECT MAX(SALARY)
        FROM employee
    )
);
###########################################################
SELECT DEPT_NAME, SALARY 
FROM employee
ORDER BY SALARY DESC
LIMIT 2 ;
###########################################################
select DEPT_NAME , salary
FROM (
	SELECT DEPT_NAME , SALARY,
    ROW_NUMBER() OVER (order by SALARY DESC) AS RANK_SALARY
    FROM employee
    ) as x
where RANK_SALARY = 2;
#########################################################


01 --  -How to search Filter records from the two Tables with out where statement

select e.EmployeeID , e.FirstName  , e.salary , D.DepartmentName
from Employees e
join  Department D on e.EmployeeID = D.DepartmentID and D.DepartmentName in ('HR','IT');

################################################################################################

02 ---THIS IS FOR TABLE COPE ONLY NOT FOR DATA AND COLUMN-----

	create table employees_new
	select * from employees
	where 1=0;

---THIS IS FOR COLUMN ONLY---

	insert into employees_new (EmployeeID , FirstName , LastName , Salary , Jobtitle)
	select EmployeeID , FirstName , LastName , Salary , Jobtitle
	from employees ;

	insert into employees_new2
	select * from employees;

	create table employee_new2
	select * from employees
	where 1=0;

	insert into employee_new2
	select * from employees;


	create table employee_new3
	select EmployeeID , FirstName , LastName , Salary , Jobtitle
	from employees
	where 1=0;
	select * from employee_new3;

	insert into employee_new3
	select EmployeeID , FirstName , LastName , Salary , Jobtitle
	from employees;
	select * from employee_new3;
	rename table employee_new3 to employee_new4;

    ####################################################################################

03 -- Find the list of employees whose salary ranges between 2L to 3L.

SELECT EmpName, Salary FROM Employee
WHERE Salary > 200000 AND Salary < 300000
--- OR –--
SELECT EmpName, Salary FROM Employee
WHERE Salary BETWEEN 200000 AND 300000

####################################################################################

04 -- Write a query to retrieve the list of employees from the same city
SELECT E1.EmpID, E1.EmpName, E1.City
FROM Employee E1, Employee E2
WHERE E1.City = E2.City AND E1.EmpID != E2.EmpID

#################################################################################
05 -- Query to find the cumulative sum of employee’s salary.
SELECT EmpID, Salary, SUM(Salary) OVER (ORDER BY EmpID) AS CumulativeSum
FROM Employee

##############################################################################
06 -- Write a query to fetch 50% records from the Employee table.
select * from employee
where EmpID <= (select count(EmpID)/2 from employee)
-----or-------
WITH rana AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY EmpID) AS rownumber
    FROM employee
)
SELECT *
FROM rana
WHERE rownumber <= (SELECT FLOOR(COUNT(EmpID) / 2) FROM employee);

############################################################################################
07 -- Write a query to fetch even and odd rows from Employee table.
WITH argha as (
	select * , 
			row_number() over (order by EmpID ) as row_num
	from employee
)
select * 
from argha
WHERE row_num % 2 = 0
------or------
select *  from
		(select * ,row_number() over (order by EmpID ) as row_num
        from employee) as argha
where argha.row_num % 2 = 0
#############################################################
08 -- : Write a query to find all the Employee names whose name:
-- • Begin with ‘A’
-- • Contains ‘A’ alphabet at second place
-- • Contains ‘Y’ alphabet at second last place
-- • Ends with ‘L’ and contains 4 alphabets 
-- • Begins with ‘V’ and ends with ‘A’

select Empname from employee
						where Empname like 'A%'
						where Empname like '_A%'
						where Empname like '_Y%'
						where Empname like '___L'
						where Empname like 'V%A'
###############################################################						

09 --  Write a query to find the list of Employee names which is:
-- • starting with vowels (a, e, i, o, or u), without duplicates
-- • ending with vowels (a, e, i, o, or u), without duplicates
-- • starting & ending with vowels (a, e, i, o, or u), without duplicates

SELECT DISTINCT Empname 
from employee
where lower(left(Empname, 1)) in ('a', 'e', 'i', 'o', 'u')
order by Empname
##################################################################

10 -- : Find Nth highest salary from employee table with and without using the
-- TOP/LIMIT keywords.
select *
from(
	select 
		EmpID,
		salary,
		row_number() over (order by salary desc) as hightst_salary
	from employee 
) as e
where e.hightst_salary = 9

--------or-------
SELECT Salary FROM Employee E1
WHERE 9 = (
SELECT COUNT( DISTINCT ( E2.Salary ) )
FROM Employee E2
WHERE E2.Salary >= E1.Salary );
######################################################################
11 -- Write a query to find and remove duplicate records from a table.

select City , count(*) as duplicate_count
from Employee
group by City
having count(*) > 1

------------------or--------------------

with rana as (
	select City ,
    row_number() over (PARTITION By City ) as duplicate_count
    from Employee
)
select City , duplicate_count
from rana
where duplicate_count > 2

################################################################
12 --  Query to retrieve the list of employees working in same project.



##########################################################################
13 -- Show the employee with the highest salary for each project

select max(salary) as dep_salary , Department 
from Employee e
join emp_detail ed
on e.EmpID = ed.EmpID
group by Department
---------------or------------

WITH argha AS (
    SELECT 
        e.EmpID,
        ed.Department,
        e.Salary,
        ROW_NUMBER() OVER (PARTITION BY ed.Department ORDER BY e.Salary) AS salary_rank
    FROM 
        employee e
    INNER JOIN 
        emp_detail ed ON e.EmpID = ed.EmpID
)
SELECT 
    EmpID,
    Department,
    Salary
FROM 
    argha
WHERE 
    salary_rank = 1;


###########################################################################
14 -- : Query to find the total count of employees joined each year
select 
	count(EmpID) as emp_count ,
	extract( year from HireDate) as Hireyear
from emp_detail
group by 
	extract(year from HireDate)
order by 
	Hireyear

###########################################################################
15 --  Create 3 groups based on salary col, salary less than 1L is low, between 1 -
-- 2L is medium and above 2L is High
select 
	salary,
    Gender,
    case 
		when salary <= 50000 then 'salary less'
		when salary between 50000 and 54000 then 'salary medium'
		when salary <= 65000 then 'salary high'
	end as salary_cat
from employee
############################################################################
16--wright the query difference between hights salary 'sales' and ' IT' depertment

WITH cte AS (
    SELECT em.Department,
           MAX(e.salary) AS max_salary
    FROM employee e
    JOIN emp_detail em ON e.EmpID = em.EmpID
    GROUP BY em.Department
)
SELECT 
    max(CASE WHEN Department = 'Sales' THEN max_salary ELSE 0 END) - 
    max(CASE WHEN Department = 'IT' THEN max_salary ELSE 0 END) AS salary_difference
FROM cte;
