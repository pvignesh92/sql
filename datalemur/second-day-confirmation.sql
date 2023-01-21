-- https://datalemur.com/questions/second-day-confirmation
SELECT e.user_id
FROM emails e
    INNER JOIN texts t ON e.email_id = t.email_id
WHERE t.signup_action = 'Confirmed'
    AND date_part('day', t.action_date - e.signup_date) = 1
ORDER BY user_id;