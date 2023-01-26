-- Run the following command to add and update dob column in employee table
alter table employee
add dob date;
update employee
set dob = dateadd(year, -1 * emp_age, getdate())
select *
from employee;
-- 1- write a query to print emp name , their manager name and diffrence in their age (in days) 
-- for employees whose year of birth is before their managers year of birth
select e1.emp_name,
    datepart(year, e1.dob) as emp_birth_year,
    e2.emp_name as manager_name,
    e1.emp_name,
    datepart(year, e2.dob) as mgr_birth_year,
    datediff(day, e1.dob, e2.dob) as age_difference_in_days
FROM employee e1
    INNER JOIN employee e2 ON e1.manager_id = e2.emp_id
where datepart(year, e1.dob) < datepart(year, e2.dob);
-- 2- write a query to find subcategories who never had any return orders in the month of november (irrespective of years)
select top 5 *
from Orders;
select *
from returns;
select sub_category
from Orders o
    left join returns r on o.order_id = r.order_id
where DATEPART(month, order_date) = 11
group by sub_category
having count(r.order_id) = 0;
-- 3- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
-- write a query to find order ids where there is only 1 product bought by the customer.
select *
from Orders;
select order_id,
    count(order_id) as order_count
from Orders
GROUP BY order_id
having count(order_id) = 1;
-- 4- write a query to print manager names along with the comma separated list(order by emp salary) 
-- of all employees directly reporting to him.
select e2.emp_name as manager_name,
    STRING_AGG(e1.emp_name, ';') WITHIN GROUP (
        ORDER BY e1.salary
    ) as reportees
from employee e1
    INNER JOIN employee e2 ON e1.manager_id = e2.emp_id
GROUP BY e2.emp_name;
-- 5- write a query to get number of business days between order_date and ship_date (exclude weekends). 
-- Assume that all order date and ship date are on weekdays only
select order_id,
    order_date,
    ship_date,
    datediff(day, order_date, ship_date) diff_in_days,
    datediff(week, order_date, ship_date) as diff_in_Week,
    datediff(day, order_date, ship_date) - 2 * datediff(week, order_date, ship_date) as diff_in_num_of_bus_days
FROM Orders
ORDER BY diff_in_days DESC;
-- 6- write a query to print 3 columns : category, total_sales and (total sales of returned orders)
select category,
    SUM(sales) as total_sales,
    SUM(
        CASE
            WHEN r.order_id is not null THEN sales
            ELSE 0
        END
    ) as total_sales_returned_orders
from Orders o
    left join returns r on o.order_id = r.order_id
group by category;
-- 7- write a query to print below 3 columns
-- category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)
select category,
    SUM(
        CASE
            WHEN datepart(year, order_date) = 2019 THEN sales
        END
    ) as total_sales_2019,
    SUM(
        CASE
            WHEN datepart(year, order_date) = 2020 THEN sales
        END
    ) as total_sales_2020
FROM Orders
GROUP BY category;
-- 8- write a query print top 5 cities in west region by average no of days between order date and ship date.
select top 5 city,
    avg(datediff(day, order_date, ship_date)) as avg_diff_days
from Orders
where region = 'West'
GROUP BY city
ORDER BY avg_diff_days DESC;
-- 9- write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)
select *
from employee;
select e1.emp_name,
    e2.emp_name as mgr_name,
    e3.emp_name as sm_name
from employee e1
    INNER JOIN employee e2 ON e1.manager_id = e2.emp_id
    INNER JOIN employee e3 ON e2.manager_id = e3.emp_id;