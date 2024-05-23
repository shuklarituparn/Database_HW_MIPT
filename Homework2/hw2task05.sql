SELECT
    m.surname,
    m.firstname,
    m.memid,
    MIN(b.starttime) AS starttime
FROM
    cd.members AS m
JOIN
    cd.bookings AS b ON m.memid = b.memid
WHERE
    b.starttime > '2012-09-01'
GROUP BY
    m.surname,
    m.firstname,
    m.memid
ORDER BY
    m.memid;

