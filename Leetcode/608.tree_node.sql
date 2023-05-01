--  608. Tree Node
-- Root --> Parent id will be null
with ctas_root AS (
    SELECT
        id,
        'Root' as type
    from
        tree
    where
        p_id is null
),
-- Inner --> Parent ID will not be null and id available as Parent ID
ctas_inner AS (
    select
        id,
        'Inner' as type
    from
        tree
    where
        id IN (
            select
                distinct p_id
            from
                tree
            where
                p_id is not null
        )
        AND p_id is not null
),
-- Leaf --> Parent ID will not be null and id not available as Parent ID
ctas_leaf AS (
    select
        id,
        'Leaf' as type
    from
        tree
    where
        id NOT IN (
            select
                distinct p_id
            from
                tree
            where
                p_id is not null
        )
        AND p_id is not null
)
select
    id,
    type
from
    ctas_root
UNION
select
    id,
    type
from
    ctas_inner
UNION
select
    id,
    type
from
    ctas_leaf
ORDER BY
    id;