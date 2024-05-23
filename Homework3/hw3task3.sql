WITH TotalHours AS (
    SELECT m.memid, m.firstname, m.surname,
    ROUND(SUM(b.slots) / 2.0, -1) AS rounded_hours
    FROM cd.bookings b
    JOIN cd.members m ON b.memid = m.memid
    GROUP BY m.memid, m.firstname, m.surname)
SELECT firstname, surname, rounded_hours AS hours,
    RANK() OVER (ORDER BY rounded_hours DESC) AS rank
FROM TotalHours
ORDER BY rank, surname, firstname;
