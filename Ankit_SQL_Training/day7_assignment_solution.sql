--- Run below table script to create icc_world_cup table:
create table icc_world_cup (
    Team_1 Varchar(20),
    Team_2 Varchar(20),
    Winner Varchar(20)
);
INSERT INTO icc_world_cup
values('India', 'SL', 'India');
INSERT INTO icc_world_cup
values('SL', 'Aus', 'Aus');
INSERT INTO icc_world_cup
values('SA', 'Eng', 'Eng');
INSERT INTO icc_world_cup
values('Eng', 'NZ', 'NZ');
INSERT INTO icc_world_cup
values('Aus', 'India', 'India');
-- 1- write a query to produce below output from icc_world_cup table.
-- team_name, no_of_matches_played , no_of_wins , no_of_losses
select *
from icc_world_cup;
-- Approach 1
with ctas_iq AS (
    select Team_1 as Team,
        SUM(
            CASE
                WHEN Team_1 = Winner THEN 1
                ELSE 0
            END
        ) as Wins,
        SUM(
            CASE
                WHEN Team_2 = Winner THEN 1
                ELSE 0
            END
        ) as Loses
    FROM icc_world_cup
    GROUP BY Team_1
    UNION All
    select Team_2 as Team,
        SUM(
            CASE
                WHEN Team_2 = Winner THEN 1
                ELSE 0
            END
        ) as Wins,
        SUM(
            CASE
                WHEN Team_1 = Winner THEN 1
                ELSE 0
            END
        ) as Loses
    FROM icc_world_cup
    GROUP BY Team_2
)
select Team,
    count(*) as total_matches,
    sum(Wins) as total_wins,
    sum(Loses) as total_loses
FROM ctas_iq
GROUP BY Team;
-- Approach 2 
with ctas_iq AS (
    select Team_1 as Team,
        CASE
            WHEN Team_1 = Winner THEN 1
            ELSE 0
        END as points
    FROM icc_world_cup
    UNION All
    select Team_2 as Team,
        CASE
            WHEN Team_2 = Winner THEN 1
            ELSE 0
        END as points
    FROM icc_world_cup
)
select Team,
    count(*) as total_matches,
    sum(points) as total_wins,
    count(*) - sum(points) as total_loses
FROM ctas_iq
GROUP BY Team;
-- 2- write a query to print first name and last name of a customer using orders table(
--everything after first space can be considered as last name)
-- customer_name, first_name,last_name
select top 5 customer_name
from Orders;
select distinct customer_name,
    substring(customer_name, 1, CHARINDEX(' ', customer_name)) as first_name,
    substring(
        customer_name,
        CHARINDEX(' ', customer_name) + 1,
        len(customer_name)
    ) as last_name
from Orders;
-- Run below script to create drivers table:
create table drivers(
    id varchar(10),
    start_time time,
    end_time time,
    start_loc varchar(10),
    end_loc varchar(10)
);
insert into drivers
values('dri_1', '09:00', '09:30', 'a', 'b'),
('dri_1', '09:30', '10:30', 'b', 'c'),
('dri_1', '11:00', '11:30', 'd', 'e');
insert into drivers
values('dri_1', '12:00', '12:30', 'f', 'g'),
('dri_1', '13:30', '14:30', 'c', 'h');
insert into drivers
values('dri_2', '12:15', '12:30', 'f', 'g'),
('dri_2', '13:30', '14:30', 'c', 'h');
--3- write a query to print below output using drivers table. 
--Profit rides are the no of rides where end location of a ride is same as start location of immediate next ride for a driver
--id, total_rides , profit_rides
dri_1,
5,
1 dri_2,
2,
0
select *
from drivers;
with ctas_iq AS (
    select *,
        lead(start_loc) over (
            partition by id
            order by start_time
        ) as next_start_loc
    FROM drivers
) -- select * from ctas_iq;
select id,
    count(*) as total_rides,
    SUM(
        CASE
            WHEN end_loc = next_start_loc THEN 1
            else 0
        END
    ) as profit
from ctas_iq
GROUP BY id;
-- Self Join
with ctas_iq AS (
    select *,
        row_number() over (
            partition by id
            order by start_time
        ) as row_num
    FROM drivers
) -- select * from ctas_iq;
select r1.id,
    count(*) as total_rides,
    SUM(
        CASE
            WHEN r2.start_loc is not null THEN 1
            else 0
        end
    ) as profit
FROM ctas_iq r1
    LEFT JOIN ctas_iq r2 ON r1.id = r2.id
    AND r1.end_loc = r2.start_loc
    and r1.row_num + 1 = r2.row_num
GROUP BY r1.id;
--4- write a query to print customer name and no of occurence of character 'n' in the customer name.
-- customer_name , count_of_occurence_of_n
select distinct top 5 customer_name
from Orders;
select distinct customer_name,
    len(customer_name) - len(replace(customer_name, 'n', '')) as n_occurances
from Orders;
--5-write a query to print below output from orders data. example output
--hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
--category , Technology, ,
--category, Furniture, ,
--category, Office Supplies, ,
--sub_category, Art , ,
--sub_category, Furnishings, ,
--and so on all the category ,subcategory and ship_mode hierarchies 
select top 5 category,
    sub_category,
    sales,
    region
from Orders;
select 'category' as hierarchy,
    category,
    SUM(
        CASE
            WHEN region = 'West' THEN sales
        END
    ) as total_sales_in_west_region,
    SUM(
        CASE
            WHEN region = 'East' THEN sales
        END
    ) as total_sales_in_east_region
FROM Orders
GROUP BY category
UNION
select 'sub_category' as hierarchy,
    sub_category,
    SUM(
        CASE
            WHEN region = 'West' THEN sales
        END
    ) as total_sales_in_west_region,
    SUM(
        CASE
            WHEN region = 'East' THEN sales
        END
    ) as total_sales_in_east_region
FROM Orders
GROUP BY sub_category
UNION
select 'ship_mode' as hierarchy,
    ship_mode,
    SUM(
        CASE
            WHEN region = 'West' THEN sales
        END
    ) as total_sales_in_west_region,
    SUM(
        CASE
            WHEN region = 'East' THEN sales
        END
    ) as total_sales_in_east_region
FROM Orders
GROUP BY ship_mode;
--6- the first 2 characters of order_id represents the country of order placed . 
-- write a query to print total no of orders placed in each country
--(an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)
select substring(order_id, 1, charindex('-', order_id) -1),
    count(*) as total_orders
from Orders
GROUP BY substring(order_id, 1, charindex('-', order_id) -1);
select left(order_id, 2) as country_code,
    count(*) as total_orders
from Orders
GROUP BY left(order_id, 2);