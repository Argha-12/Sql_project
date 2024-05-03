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