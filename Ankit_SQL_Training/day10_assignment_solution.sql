--1- write a query to print 3rd highest salaried employee details for each department 
-- (give preferece to younger employee in case of a tie). 
--In case a department has less than 3 employees then print the details of highest salaried employee in that department.
select *
from employee;
-- 1st approach 
with ctas_iq AS (
    select *,
        ROW_NUMBER() OVER (
            PARTITION BY dept_id
            ORDER BY salary DESC,
                dob DESC
        ) as rn
    FROM employee
),
ctas_max as (
    select distinct dept_id
    from employee
    GROUP BY dept_id
    having count(*) < 3
)
select *
from ctas_iq
where rn = 3
UNION
select *
from ctas_iq
where dept_id in (
        select dept_id
        from ctas_max
    );
-- 2nd approach 
with ctas_iq AS (
    select *,
        dense_rank() OVER (
            PARTITION BY dept_id
            ORDER BY salary DESC,
                dob DESC
        ) as rn
    FROM employee
),
ctas_max as (
    select dept_id,
        count(1) as cnt
    from employee
    GROUP BY dept_id
)
select distinct i.*
from ctas_iq i
    INNER JOIN ctas_max m ON i.dept_id = m.dept_id
where i.rn = 3
    OR (
        m.cnt < 3
        and i.rn = 1
    );
-- 2- write a query to find top 3 and bottom 3 products by sales in each region.
select top 10 *
from Orders;
with prod_sales AS (
    select region,
        product_id,
        sum(sales) as total_sales
    FROM Orders
    GROUP BY region,
        product_id
),
ctas_iq AS (
    select region,
        product_id,
        total_sales,
        row_number() OVER (
            PARTITION BY region
            ORDER BY total_sales DESC
        ) as desc_rn,
        row_number() OVER (
            PARTITION BY region
            ORDER BY total_sales
        ) as asc_rn
    FROM prod_sales
)
select *
from ctas_iq
where desc_rn <= 3
    or asc_rn <= 3 -- 3- Among all the sub categories..which sub category had highest month over month growth by sales in Jan 2020.
    with base_data AS (
        select sub_category,
            datepart(year, order_date) as year_of_sales,
            datepart(month, order_date) AS month_of_sales,
            sum(sales) as total_sales
        FROM Orders
        GROUP BY sub_category,
            datepart(year, order_date),
            datepart(month, order_date)
    ),
    prev_month_sales_added AS (
        select *,
            LAG(total_sales) OVER(
                PARTITION BY sub_category
                ORDER BY year_of_sales,
                    month_of_sales
            ) as prev_month_total_sales
        FROM base_data
    )
select top 1 *,
    (total_sales - prev_month_total_sales) / prev_month_total_sales AS growth
from prev_month_sales_added
where year_of_sales = 2020
    and month_of_sales = 1
ORDER BY growth DESC;
-- 4- write a query to print top 3 products in each category by year over year sales growth in year 2020.
with base_data AS (
    select category,
        product_id,
        format(order_date, 'yyyy') as year_of_sales,
        sum(sales) as total_sales
    from Orders
    GROUP BY category,
        product_id,
        format(order_date, 'yyyy')
),
prev_year_sales AS (
    select *,
        lag(total_sales) OVER (
            PARTITION BY category
            ORDER BY year_of_sales
        ) as prev_year_sales
    from base_data
),
sales_rank AS (
    select *,
        (total_sales - prev_year_sales) / prev_year_sales as growth,
        row_number() over (
            PARTITION BY category
            ORDER BY (total_sales - prev_year_sales) / prev_year_sales DESC
        ) as rn
    from prev_year_sales
    where year_of_sales = 2020
)
select *
from sales_rank
where rn <= 3 -- 5- create below 2 tables 
    create table call_start_logs (
        phone_number varchar(10),
        start_time datetime
    );
insert into call_start_logs
values ('PN1', '2022-01-01 10:20:00'),
('PN1', '2022-01-01 16:25:00'),
('PN2', '2022-01-01 12:30:00'),
('PN3', '2022-01-02 10:00:00'),
('PN3', '2022-01-02 12:30:00'),
('PN3', '2022-01-03 09:20:00');
create table call_end_logs (phone_number varchar(10), end_time datetime);
insert into call_end_logs
values ('PN1', '2022-01-01 10:45:00'),
('PN1', '2022-01-01 17:05:00'),
('PN2', '2022-01-01 12:55:00'),
('PN3', '2022-01-02 10:20:00'),
('PN3', '2022-01-02 12:50:00'),
('PN3', '2022-01-03 09:40:00');
-- write a query to get start time and end time of each call from above 2 tables.
-- Also create a column of call duration in minutes.  Please do take into account that
-- there will be multiple calls from one phone number and each entry in start table has a corresponding entry in end table.
select *
from call_start_logs;
select *
from call_end_logs;
with call_start AS (
    select *,
        ROW_NUMBER() OVER (
            PARTITION BY phone_number
            ORDER BY start_time
        ) as rn
    FROM call_start_logs
),
call_end AS (
    select *,
        ROW_NUMBER() OVER (
            PARTITION BY phone_number
            ORDER BY end_time
        ) as rn
    FROM call_end_logs
)
select cs.phone_number,
    cs.start_time,
    ce.end_time,
    datediff(minute, cs.start_time, ce.end_time) as duration
from call_start cs
    INNER JOIN call_end ce ON cs.phone_number = ce.phone_number
    AND cs.rn = ce.rn;