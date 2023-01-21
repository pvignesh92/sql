-- https://datalemur.com/questions/sql-avg-review-ratings
SELECT date_part('month', submit_date) as mth,
    product_id,
    ROUND(AVG(stars), 2) as avg_stars
FROM reviews
GROUP BY date_part('month', submit_date),
    product_id
ORDER BY mth,
    product_id;