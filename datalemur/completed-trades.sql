-- https://datalemur.com/questions/completed-trades
SELECT u.city,
    count(*) AS total_orders
FROM trades t
    INNER JOIN users u ON t.user_id = u.user_id
WHERE t.status = 'Completed'
GROUP BY city
ORDER BY total_orders DESC
LIMIT 3;