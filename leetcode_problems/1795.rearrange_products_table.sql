-- 1795. Rearrange Products Table
with ctas_union AS (
    select
        product_id,
        'store1' AS store,
        store1 as price
    FROM
        Products
    UNION
    select
        product_id,
        'store2' AS store,
        store2 as price
    FROM
        Products
    UNION
    select
        product_id,
        'store3' AS store,
        store3 as price
    FROM
        Products
)
select
    product_id,
    store,
    price
FROM
    ctas_union
WHERE
    price is not null
ORDER BY
    product_id