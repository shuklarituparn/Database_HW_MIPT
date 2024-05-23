WITH RECURSIVE recommendation_chain AS (
    SELECT
        memid,
        firstname,
        surname,
        1 AS level
    FROM
        cd.members
    WHERE
        memid = 1
    UNION ALL
    SELECT
        m.memid,
        m.firstname,
        m.surname,
        rc.level + 1
    FROM
        cd.members m
    INNER JOIN
        recommendation_chain rc ON m.recommendedby = rc.memid
)
SELECT
    memid,
    firstname,
    surname
FROM
    recommendation_chain
WHERE
    level > 1
ORDER BY
    memid;
