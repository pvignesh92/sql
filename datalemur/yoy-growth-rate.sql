-- https://datalemur.com/questions/yoy-growth-rate
with ctas_sales as (
    SELECT date_part('year', transaction_date) as year_of_sales,
        product_id,
        sum(spend) as total_spend
    FROM user_transactions
    GROUP BY date_part('year', transaction_date),
        product_id
),
ctas_prev_year AS (
    select year_of_sales,
        product_id,
        total_spend as curr_year_spend,
        lag(total_spend) OVER (
            PARTITION BY product_id
            ORDER BY year_of_sales
        ) as prev_year_spend
    from ctas_sales
)
select *,
    ROUND(
        100.0 * (curr_year_spend - prev_year_spend) / prev_year_spend,
        2
    ) as yoy_rate
from ctas_prev_year