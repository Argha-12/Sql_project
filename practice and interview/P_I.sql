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


-- -How to search Filter records from the two Tables with out where statement

select e.EmployeeID , e.FirstName  , e.salary , D.DepartmentName
from Employees e
join  Department D on e.EmployeeID = D.DepartmentID and D.DepartmentName in ('HR','IT');

################################################################################################

---THIS IS FOR TABLE COPE ONLY NOT FOR DATA AND COLUMN-----

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

    