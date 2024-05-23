SELECT 
    facid,
    EXTRACT(MONTH FROM starttime) AS month,
    SUM(slots) AS slots
FROM 
    cd.bookings
WHERE 
    starttime BETWEEN '2012-01-01' AND '2012-12-31'
GROUP BY 
    facid, month
UNION ALL
SELECT 
    facid,
    NULL,
    SUM(slots) AS slots
FROM 
    cd.bookings
WHERE 
    starttime BETWEEN '2012-01-01' AND '2012-12-31'
GROUP BY 
    facid
HAVING 
    facid IS NOT NULL
UNION ALL
SELECT 
    NULL,
    NULL,
    SUM(slots) AS slots
FROM 
    cd.bookings
WHERE 
    starttime BETWEEN '2012-01-01' AND '2012-12-31'
ORDER BY 
    facid, month;
