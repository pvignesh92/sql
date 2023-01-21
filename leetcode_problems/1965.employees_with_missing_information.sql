-- Approach 1
WITH ctas_iq AS (
    select
        e.employee_id,
        e.name,
        s.salary
    FROM
        Employees AS e
        LEFT OUTER JOIN Salaries AS s ON e.employee_id = s.employee_id
    UNION
    ALL
    select
        s.employee_id,
        e.name,
        s.salary
    FROM
        Employees AS e
        RIGHT OUTER JOIN Salaries AS s ON e.employee_id = s.employee_id
)
select
    employee_id
from
    ctas_iq
where
    name is null
    OR salary is null
ORDER BY
    employee_id;