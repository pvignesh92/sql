-- https://datalemur.com/questions/teams-power-users
-- Engine PostgreSQL
SELECT sender_id,
    count(message_id) as message_count
FROM messages
where date_part('month', sent_date) = 8
    and date_part('year', sent_date) = 2022
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;