/*
 A median is defined as a number separating the higher half of a data set from the lower half. 
 Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.
 */
-- Engine MSSQL Server
WITH ctas_iq1 AS (
    select
        ROW_NUMBER() OVER (
            ORDER BY
                lat_n ASC
        ) as row_num,
        id,
        lat_n
    FROM
        station
),
ctas_iq2 AS (
    select
        CASE
            WHEN max(row_num) % 2 = 0 THEN max(row_num) / 2
            ELSE max(row_num) / 2 + 1
        END AS max_num
    FROM
        ctas_iq1
)
select
    CAST(lat_n AS DECIMAL(38, 4))
FROM
    ctas_iq1
WHERE
    row_num in (
        select
            max_num
        from
            ctas_iq2
    );