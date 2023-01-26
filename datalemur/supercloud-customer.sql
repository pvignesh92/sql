-- https://datalemur.com/questions/supercloud-customer

select customer_id
from (
        select c.customer_id,
            count(distinct product_category) as total_categories
        FROM customer_contracts c
            INNER JOIN products p ON c.product_id = p.product_id
        GROUP BY customer_id
    ) a
where total_categories = (
        select count(distinct product_category)
        from products
    )