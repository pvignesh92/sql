/*
 We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
 Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as  space-separated integers.
 */
-- Engine MSSQL server
WITH ctas_iq AS (
    select
        employee_id,
        name,
        months,
        salary,
        (months * salary) as total_salary
    FROM
        employee
)
select
    TOP 1 total_salary,
    COUNT(name)
from
    ctas_iq
GROUP BY
    total_salary
ORDER BY
    total_salary DESC
    