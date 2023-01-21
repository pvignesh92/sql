-- https://datalemur.com/questions/sql-average-post-hiatus-1
-- Engine - PostgreSQL
select user_id,
    DATE_PART('day', max(post_date) - min(post_date)) as days_between
FROM posts
where post_date between '01-01-2021' and '12-31-2021'
GROUP BY user_id
having count(user_id) > 1
ORDER BY user_id;