-- 176. Second Highest Salary
select
    COALESCE(max(salary), null) as SecondHighestSalary
from
    employee
where
    salary not in (
        select
            max(salary) as salary
        from
            employee
    )