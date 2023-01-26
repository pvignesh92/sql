-- https://datalemur.com/questions/long-calls-growth
with ctas_callers AS (
    SELECT date_part('year', call_received) as year,
        date_part('month', call_received) as month,
        call_duration_secs
    FROM callers
    where call_duration_secs > 300 
),
ctas_summary as (
    select year,
        month,
        count(*) as total_calls
    FROM ctas_callers
    GROUP BY year,
        month
),
ctas_call_details AS (
    select year,
        month,
        total_calls as curr_month_calls,
        LAG(total_calls) OVER (
            ORDER BY year,
                month
        ) as prev_month_calls
    FROM ctas_summary
)
select year as yr,
    month as mth,
    ROUND(
        100.0 * (curr_month_calls - prev_month_calls) / prev_month_calls,
        1
    ) as growth_pct
from ctas_call_details