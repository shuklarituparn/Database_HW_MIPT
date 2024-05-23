SELECT DISTINCT
    m1.firstname,
    m1.surname
FROM
    cd.members m1
JOIN
    cd.members m2 ON m1.memid = m2.recommendedby
WHERE
    m2.recommendedby IS NOT NULL
ORDER BY
    m1.surname, m1.firstname;
