-- 1- write a update statement to update city as null for order ids :  
UPDATE Orders
set city = null
where order_id in ('CA-2020-161389', 'US-2021-156909');
select *
from Orders
where order_id in ('CA-2020-161389', 'US-2021-156909');
-- 2- write a query to find orders where city is null (2 rows)
select *
from Orders
where city is null;
-- 3- write a query to get total profit, first order date and latest order date for each category
select category,
    sum(profit) as total_profit,
    min(order_date) as first_order_date,
    max(order_date) as latest_order_date
from Orders
GROUP BY category;
-- 4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category
select sub_category,
    avg(profit) as avg_profit,
    max(profit) as max_profit
from Orders
GROUP BY sub_category
having avg(profit) > max(profit) / 2;
-- 5- create the exams table with below script;
create table exams (student_id int, subject varchar(20), marks int);
insert into exams
values (1, 'Chemistry', 91),
(1, 'Physics', 91),
(1, 'Maths', 92),
(2, 'Chemistry', 80),
(2, 'Physics', 90),
(3, 'Chemistry', 80),
(3, 'Maths', 80),
(4, 'Chemistry', 71),
(4, 'Physics', 54),
(5, 'Chemistry', 79);
select *
from exams;
-- write a query to find students who have got same marks in Physics and Chemistry.
select student_id,
    marks,
    count(*)
from exams
where subject in ('Chemistry', 'Physics')
GROUP BY student_id,
    marks
having count(*) = 2;
-- 6- write a query to find total number of products in each category.
select top 5 *
from Orders;
select category,
    count(distinct product_id)
from Orders
GROUP BY category;
-- 7- write a query to find top 5 sub categories in west region by total quantity sold
select top 5 sub_category,
    sum(quantity) as total_quantity_sold
from Orders
where region = 'West'
GROUP BY sub_category
ORDER BY total_quantity_sold DESC;
-- 8- write a query to find total sales for each region and ship mode combination for orders in year 2020
select region,
    ship_mode,
    sum(sales)
FROM Orders
WHERE order_date between '2020-01-01' and '2020-12-31'
GROUP BY region,
    ship_mode;