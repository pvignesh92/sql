
-- https://datalemur.com/questions/signup-confirmation-rate

select ROUND(1.0 * count(t.email_id) / count(e.email_id), 2)
from emails e
    LEFT JOIN (
        select email_id
        from texts
        WHERE signup_action = 'Confirmed'
    ) t ON e.email_id = t.email_id;