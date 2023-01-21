-- https://datalemur.com/questions/laptop-mobile-viewership
SELECT SUM(
        CASE
            WHEN device_type in ('laptop') THEN 1
            ELSE 0
        END
    ) as laptop_views,
    SUM(
        CASE
            WHEN device_type in ('phone', 'tablet') THEN 1
            ELSE 0
        END
    ) as mobile_views
FROM viewership;