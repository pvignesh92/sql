-- Write an SQL query to report all customers who never order anything.
-- Return the result table in any order.
-- Approach 1 using Inner Query
select
    name as customers
from
    customers AS c
where
    c.id not in (
        select
            customerid
        from
            orders
    ) 
    
-- Approach 2 using Join
select
    name as Customers
from
    (
        select
            c.name,
            o.customerId
        FROM
            customers AS c
            LEFT JOIN orders AS o ON (c.id = o.customerId)
    ) a
where
    customerId is null;