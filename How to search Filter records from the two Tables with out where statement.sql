----1st table----
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);


----2nd table----

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName  VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Jobtitle VARCHAR(50) NOT NULL,
    Salary int ,
    HireDate date,
    DOB date 
);

------2nd tables data----

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Jobtitle, Salary, HireDate, DOB)
VALUES
(1, 1, 'John', 'Doe', 'Software Engineer', 80000, '2023-01-15', '1990-05-10'),
(2, 2, 'Jane', 'Smith', 'Database Administrator', 75000, '2023-02-20', '1988-09-22'),
(3, 3, 'Michael', 'Johnson', 'Project Manager', 90000, '2022-11-10', '1985-12-18'),
(4, 4, 'Emily', 'Brown', 'Business Analyst', 85000, '2023-03-05', '1992-07-31');

select * from Department;
select * from Employees;

---- this is solition ####-----

select e.EmployeeID , e.FirstName  , e.salary , D.DepartmentName
from Employees e
join  Department D on e.EmployeeID = D.DepartmentID and D.DepartmentName in ('HR','IT');
