-- https://datalemur.com/questions/top-fans-rank
SELECT a.artist_id,
    a.artist_name,
    s.song_id,
    gsr.day,
    gsr.rank
FROM artists a
    INNER JOIN songs s ON (a.artist_id = s.artist_id)
    INNER JOIN global_song_rank gsr ON (s.song_id = gsr.song_id)
),
ctas_song_appearances AS (
    select artist_name,
        count(*) as song_appearances
    FROM ctas_iq
    where rank <= 10
    GROUP BY artist_name
)
select *
from (
        select artist_name,
            dense_rank() OVER (
                ORDER BY song_appearances DESC
            ) as artist_rank
        FROM ctas_song_appearances
    ) a
where artist_rank <= 5
ORDER BY artist_rank