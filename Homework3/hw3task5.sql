WITH revenue_per_facility AS (
    SELECT
        f.name,
        SUM(
            CASE
                WHEN b.memid = 0 THEN b.slots * f.guestcost
                ELSE b.slots * f.membercost
            END
        ) AS total_revenue
    FROM
        cd.facilities AS f
    INNER JOIN
        cd.bookings AS b ON f.facid = b.facid
    GROUP BY
        f.facid, f.name
)
SELECT
    name,
    RANK() OVER (ORDER BY total_revenue DESC) AS rank
FROM
    revenue_per_facility
ORDER BY
    rank, name
LIMIT 3;
