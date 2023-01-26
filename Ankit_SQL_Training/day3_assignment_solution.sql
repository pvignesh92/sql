--1- write a sql to get all the orders where customers name has "a" as second character 
--and "d" as fourth character (58 rows)
select order_id,
    order_date,
    customer_name
from Orders
where customer_name like '_a_d%';
--2- write a sql to get all the orders placed in the month of dec 2020 (352 rows) 
select *
from Orders
where order_date between '2020-12-01' and '2020-12-31';
-- 3- write a query to get all the orders where ship_mode is neither in 'Standard Class' nor in 'First Class' and ship_date is after nov 2020 (944 rows)
select *
from Orders
WHERE ship_mode not in ('Standard Class', 'First Class')
    AND ship_date > '2020-11-30';
-- 4- write a query to get all the orders where customer name does not start with "A" and end with "n" (9815 rows)
select *
from Orders
WHERE customer_name not like 'A%n';
select *
from Orders
WHERE NOT (
        customer_name like 'A%'
        and customer_name like '%n'
    );
select *
from Orders
WHERE customer_name not like 'A%'
    or customer_name not like '%n';
-- 5- write a query to get all the orders where profit is negative (1871 rows)
select *
from Orders
where profit < 0;
-- 6- write a query to get all the orders where either quantity is less than 3 or profit is 0 (3348)
select *
from Orders
where profit = 0
    or quantity < 3;
-- 7- your manager handles the sales for South region and he wants you to create a report of all the orders 
--in his region where some discount is provided to the customers (815 rows)
select count(*)
from Orders
where region = 'South'
    AND discount <> 0;
-- 8- write a query to find top 5 orders with highest sales in furniture category 
select top 5 *
from Orders
where category = 'Furniture'
order by sales desc;
-- 9- write a query to find all the records in technology and furniture category for the orders placed in the year 2020 only (1021 rows)
select count(*)
from Orders
where LOWER(category) IN ('furniture', 'technology')
    AND order_date between '2020-01-01' and '2020-12-31';
-- 10-write a query to find all the orders where order date is in year 2020 but ship date is in 2021 (33 rows)
select count(*)
from Orders
where order_date between '2020-01-01' and '2020-12-31'
    AND ship_date between '2021-01-01' and '2021-12-31';