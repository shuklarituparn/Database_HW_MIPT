SELECT
    UPPER(full_nm) as full_name,
    dt,
    high_price as price
FROM
    (SELECT
        full_nm,
        dt,
        high_price,
        RANK() OVER (PARTITION BY full_nm ORDER BY high_price DESC, dt ASC) AS rank
    FROM
        coins) subquery
WHERE
    subquery.rank = 1
ORDER BY
    high_price DESC, full_nm;
