/* Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing the calculation. 
She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer. */

-- Engine : MSSQL Server

WITH ctas_iq AS (
SELECT top 100 id, 
name, 
CAST(salary AS FLOAT) as actual,
CAST(REPLACE(CAST(salary as VARCHAR),'0','') AS FLOAT) as miscalculated
FROM employees 
),
ctas_iq2 AS (
select  
SUM(actual) / COUNT(*) as actual_avg,
SUM(miscalculated) / COUNT(*) as miscalculated_avg
from ctas_iq
)

select CAST(CEILING(actual_avg - miscalculated_avg) AS INT) from ctas_iq2
