--1- write a query to find premium customers from orders data.
--Premium customers are those who have done more orders than average no of orders per customer.
select top 5 *
from Orders;
with ctas_total_orders AS (
    select customer_id,
        count(distinct order_id) as total_orders
    from Orders
    GROUP BY customer_id
)
select customer_id
FROM ctas_total_orders
where total_orders > (
        select avg(total_orders)
        from ctas_total_orders
    ) --
    -- 2- write a query to find employees whose salary is more than average salary of employees in their department
select *
from employee;
with ctas_avg_salary AS (
    select dept_id,
        avg(salary) as avg_salary
    FROM employee
    GROUP BY dept_id
)
select e.*,
    s.*
from employee e
    INNER JOIN ctas_avg_salary s ON (e.dept_id = s.dept_id)
where e.salary > s.avg_salary;
-- 3- write a query to find employees whose age is more than average age of all the employees.
select *
from employee;
select *,
    (
        select avg(emp_age)
        from employee
    ) as avg_age
from employee
where emp_age > (
        select avg(emp_age)
        from employee
    );
-- 4- write a query to print emp name, salary and dep id of highest salaried employee in each department 
with ctas_max_salary AS (
    select dept_id,
        max(salary) as max_salary
    FROM employee
    GROUP BY dept_id
)
select distinct e.dept_id,
    e.salary,
    e.dept_id,
    s.max_salary
from employee e
    INNER JOIN ctas_max_salary s ON e.dept_id = s.dept_id
    AND e.salary = s.max_salary;
-- 5- write a query to print emp name, salary and dep id of highest salaried overall
select *
from employee;
select emp_name,
    salary,
    dept_id
from employee
where salary = (
        select max(salary)
        from employee
    ) -- 6- write a query to print product id and total sales of highest selling products (by no of units sold) in each category
select *
from Orders;
with ctas_total_units as (
    select category,
        product_id,
        sum(quantity) as total_units
    FROM Orders
    GROUP BY category,
        product_id
),
ctas_max_units AS (
    select category,
        max(total_units) as max_number_sold
    FROM ctas_total_units
    GROUP BY category
),
ctas_product_max_sold AS (
    select t1.*,
        t2.max_number_sold
    FROM ctas_total_units t1
        INNER JOIN ctas_max_units t2 ON t1.category = t2.category
        AND t1.total_units = t2.max_number_sold
)
select *
from ctas_product_max_sold;