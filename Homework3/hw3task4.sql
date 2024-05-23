WITH tb AS (SELECT DISTINCT(name), SUM(CASE
 WHEN b.memid = 0 THEN f.guestcost * b.slots
 ELSE f.membercost * b.slots
END) OVER (PARTITION BY name) AS cost
FROM cd.facilities f JOIN cd.bookings b ON f.facid = b.facid)
SELECT * FROM (SELECT t.name, CASE
 WHEN t.ntile = 1 THEN 'high'
 WHEN t.ntile = 2 THEN 'average'
 ELSE 'low'
END AS revenue
FROM (SELECT tb.name, NTILE(3) OVER(ORDER BY tb.cost DESC) FROM tb ORDER BY cost DESC) AS t) AS b ORDER BY CASE b.revenue
    WHEN 'high' THEN 1
    WHEN 'average' THEN 2
    WHEN 'low' THEN 3
END, name;
