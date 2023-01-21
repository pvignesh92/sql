-- https://datalemur.com/questions/click-through-rate
SELECT app_id,
    ROUND(
        100.0 * count(
            CASE
                WHEN event_type = 'click' THEN 1
                ELSE NULL
            end
        ) / count(
            CASE
                WHEN event_type = 'impression' THEN 1
                ELSE NULL
            end
        ),
        2
    ) as cr
FROM events
WHERE date_part('year', timestamp) = 2022
GROUP BY app_id;