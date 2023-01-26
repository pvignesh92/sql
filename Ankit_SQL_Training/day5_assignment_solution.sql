select *
from returns;
select *
from Orders;
-- 1- write a query to get region wise count of return orders
select o.region,
    count(distinct r.order_id) as return_orders
from Orders o
    INNER JOIN returns r ON o.order_id = r.order_id
GROUP BY o.region;
-- 2- write a query to get category wise sales of orders that were not returned
select o.category,
    sum(o.sales) as total_sales
from Orders o
    LEFT JOIN returns r ON o.order_id = r.order_id
where r.order_id is null
GROUP BY o.category;
-- 3- write a query to print dep name and average salary of employees in that dep .
select *
from employee;
select *
from dept;
select d.dep_name,
    avg(e.salary) as avg_salary
from dept d
    INNER JOIN employee e ON e.dept_id = d.dep_id
GROUP BY dep_name -- 4- write a query to print dep names where none of the emplyees have same salary.
select d.dep_name
from dept d
    INNER JOIN employee e ON e.dept_id = d.dep_id
GROUP BY dep_name
having count(emp_id) = count(distinct salary) -- 5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
select o.sub_category
from Orders o
    INNER JOIN returns r ON o.order_id = r.order_id
GROUP BY o.sub_category
having count(distinct r.return_reason) = 3;
-- 6- write a query to find cities where not even a single order was returned.
select distinct o.city,
    count(r.order_id)
from Orders o
    LEFT JOIN returns r ON o.order_id = r.order_id
GROUP BY city
having count(r.order_id) = 0;
-- 7- write a query to find top 3 subcategories by sales of returned orders in east region
select top 3 o.sub_category,
    sum(sales) as total_sales
from Orders o
    INNER JOIN returns r ON o.order_id = r.order_id
where o.region = 'East'
GROUP BY o.sub_category
ORDER BY total_sales DESC;
-- 8- write a query to print dep name for which there is no employee
select *
from employee;
select *
from dept;
select d.dep_name
FROM dept d
    LEFT JOIN employee e ON d.dep_id = e.dept_id
GROUP BY d.dep_name
having count(e.emp_name) = 0;
-- 9- write a query to print employees name for dep id is not avaiable in dept table
select e.emp_name,
    d.dep_id
FROM employee e
    LEFT JOIN dept d ON e.dept_id = d.dep_id
where d.dep_id is null