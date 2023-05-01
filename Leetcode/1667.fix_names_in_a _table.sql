-- 1667. Fix Names in a Table
select
    user_id,
    CONCAT(
        UPPER(SUBSTR(name, 1, 1)),
        LOWER(SUBSTR(name, 2, length(name)))
    ) as name
FROM
    users
ORDER BY
    user_id