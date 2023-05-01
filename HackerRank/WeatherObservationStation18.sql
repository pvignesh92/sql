/*Consider P1(a,c) and  P2(b,d) to be two points on a 2D plane.

 happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 happens to equal the maximum value in Western Longitude (LONG_W in STATION).

 Query the Manhattan Distance between points  P1 and P2 and  and round it to a scale of 4 decimal places. 
*/

/*
Manhattan Distance : 
The distance between two points measured along axes at right angles. In a plane with p1 at (x1, y1) and p2 at (x2, y2), it is |x1 - x2| + |y1 - y2|.
*/

-- Engine MSSQL server
WITH ctas_iq AS (
select 
    min(lat_n) as a,
    min(long_w) as b,
    max(lat_n) as c,
    max(long_w) as d
FROM 
    station
)

select CAST(ABS(c-a) + ABS(d-b) AS DECIMAL(38,4)) FROM ctas_iq;

