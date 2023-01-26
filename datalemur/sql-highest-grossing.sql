-- https://datalemur.com/questions/sql-highest-grossing
with ctas_iq AS (
    select category,
        product,
        sum(spend) as total_spend
    FROM product_spend
    where date_part('year', transaction_date) = 2022
    GROUP BY category,
        product
),
ctas_rnk AS (
    select *,
        row_number() OVER (
            PARTITION BY category
            ORDER BY total_spend DESC
        ) as rnk
    from ctas_iq
)
select category,
    product,
    total_spend
from ctas_rnk
where rnk <= 2