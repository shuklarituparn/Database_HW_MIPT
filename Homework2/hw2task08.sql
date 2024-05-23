SELECT 
    CONCAT(m.firstname, ' ', m.surname) AS member,
    f.name AS facility
FROM 
    cd.members m
JOIN 
    cd.bookings b ON m.memid = b.memid
JOIN 
    cd.facilities f ON b.facid = f.facid
WHERE 
    f.name LIKE 'Tennis Court%'
GROUP BY 
    m.memid, f.facid
ORDER BY 
    member, facility;
