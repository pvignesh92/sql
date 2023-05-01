-- 1484. Group Sold Products By The Date
select
    sell_date,
    count(distinct product) as num_sold,
    group_concat(distinct product) as products
from
    Activities
GROUP BY
    sell_date
ORDER BY
    sell_date