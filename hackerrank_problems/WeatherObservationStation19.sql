/*
 Consider  P1(a,c) and  P2(b,d) to be two points on a 2D plane where  are the respective minimum and maximum values of 
 Northern Latitude (LAT_N) and  are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.
 
 Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.
 */
--Engine MSSQL Server
WITH ctas_iq AS (
    select
        min(lat_n) as a,
        max(lat_n) as b,
        min(long_w) as c,
        max(long_w) as d
    FROM
        station
)
select
    CAST(SQRT((b - a) *(b - a) + (d - c) *(d - c)) AS DECIMAL(38, 4))
FROM
    ctas_iq;