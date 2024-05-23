SELECT 
    CONCAT(m.firstname, ' ', m.surname) AS member,
    f.name AS facility,
    CASE
        WHEN m.memid = 0 THEN b.slots * f.guestcost
        ELSE b.slots * f.membercost
    END AS cost
FROM 
    cd.bookings b
JOIN 
    cd.facilities f ON b.facid = f.facid
JOIN 
    cd.members m ON b.memid = m.memid
WHERE 
    b.starttime::date = '2012-09-14'
    AND CASE
        WHEN m.memid = 0 THEN b.slots * f.guestcost
        ELSE b.slots * f.membercost
    END > 30
ORDER BY 
    cost DESC, member, facility;
