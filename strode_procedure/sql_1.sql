DELIMITER //

CREATE PROCEDURE iphone (
    IN price_id INT,
    IN brand_id VARCHAR(50)
)
BEGIN
    SELECT * FROM product 
    WHERE brand = brand_id;

    SELECT * FROM product 
    WHERE price = price_id;
END //

DELIMITER ;

call iphone(1000, 'Apple');

use HR

select * from Employees

----input parameters in store procedure

create procedure sp_insert
	@emp_id int,
	@emp_name varchar(20),
	@department varchar(20),
	@salary int
as
begin
	insert into Employees (emp_id, emp_name , department, salary)
	values (@emp_id, @emp_name, @department,@salary)
end


exec sp_insert 
	@emp_id = 9,
	@emp_name = 'argha',
	@department = 'IT',
	@salary = 270000

select * from employees

CREATE PROCEDURE sp_UpdateSalary
    @EmpID INT,
    @Salary INT
AS
BEGIN
    UPDATE Employees
    SET Salary = @Salary
    WHERE Emp_id = @EmpID
END;


---dufalt store procuder

CREATE PROCEDURE sp_GetEmployeesByDept
    @Department VARCHAR(30) = 'IT'
AS
BEGIN
    SELECT * FROM Employees
    WHERE Department = @Department;
END;


exec sp_GetEmployeesByDept 'HR'


---output parameters in store procuders

CREATE PROCEDURE sp_DepartmentSummary
    @DeptName VARCHAR(30),
    @TotalEmp INT OUTPUT,
    @AvgSalary INT OUTPUT
AS
BEGIN
    SELECT 
        @TotalEmp = COUNT(*),
        @AvgSalary = AVG(Salary)
    FROM Employees
    WHERE Department = @DeptName;
END;


DECLARE @EmpCount INT, @AvgSal INT;

EXEC sp_DepartmentSummary
    'HR',
    @EmpCount OUTPUT,
    @AvgSal OUTPUT;

SELECT @EmpCount AS TotalEmployees, @AvgSal AS AverageSalary;


------output parameter in sp

CREATE PROCEDURE sp_TotalEmployees
    @EmpCount INT OUTPUT   -- Output parameter
AS
BEGIN
    SELECT @EmpCount = COUNT(*)
    FROM Employees;
END;


declare @Emp int
exec sp_TotalEmployees @Emp output
select @Emp

    
---Create a stored procedure to return average salary of a department using an output parameter.

create procedure avg_salary_dep
    @salary decimal (10 , 2) output,
    @department varchar (20) output
as
begin
    select
        @salary = avg(salary) 
    from Employees
    where department = @department

end;

declare @avg decimal(10,2)
exec avg_salary_dep 
    @salary = @avg output,
    @department = 'HR'

select @avg as avg_salary
    
-----create hight salary from sp
    
create procedure highest_salary
    @salary decimal (10,2) output
as
begin
    select 
        @salary = max(salary)
        from Employees
end

declare @salar decimal (10,2) 
exec highest_salary @salar output
select @salar
    


----Create a stored procedure to return employees between two salary ranges (min and max salary).(IN parameter)

create procedure salary_range
    @salary1 int,
    @salary2 int
as
begin
    select * 
    from Employees
    where salary between @salary1 and @salary2
end

exec salary_range
    @salary1 = 1000,
    @salary2 = 50000


---Create a stored procedure to return employees whose salary is greater than a given amount.

create procedure salary_greater5
    @salary int
AS
begin
    select *
    from Employees
    where salary > @salary
end

exec salary_greater5
    @salary = 300000

---Create a stored procedure to fetch employees by department and joining year.

create procedure join_years
    @years int,
    @department varchar(50)
as 
begin
    select emp_name,
            department
    from Employees
    where year(hire_date) = @years and department = @department
end

exec join_years
    @years = 2022,
    @department = 'HR'

    
-----------------------------------------------------------
create procedure department_salary_analytics_report
as 
begin
            WITH Company_Avg AS
        (
            SELECT AVG(salary) AS company_avg_salary
            FROM Employees
        ),

        Department_Stats AS
        (
            SELECT 
                department,
                COUNT(*) AS total_employees,
                AVG(salary) AS avg_salary,
                SUM(salary) AS total_salary_expense,
                MIN(salary) AS min_salary,
                MAX(salary) AS max_salary
            FROM Employees
            GROUP BY department
        ),

        Ranked_Employees AS
        (
            SELECT 
                emp_id,
                emp_name,
                department,
                salary,
                ROW_NUMBER() OVER 
                (
                    PARTITION BY department 
                    ORDER BY salary DESC
                ) AS salary_rank
            FROM Employees
        )

        SELECT 
            ds.department,
            ds.total_employees,
            ds.avg_salary,
            ds.total_salary_expense,
            ds.min_salary,
            ds.max_salary,
            re.emp_name,
            re.salary,
            re.salary_rank
        FROM Department_Stats ds
        CROSS JOIN Company_Avg ca
        INNER JOIN Ranked_Employees re
            ON ds.department = re.department
        WHERE 
            ds.avg_salary > ca.company_avg_salary
            AND re.salary_rank <= 3
        ORDER BY 
            ds.department,
            re.salary_rank;
end

exec department_salary_analytics_report

