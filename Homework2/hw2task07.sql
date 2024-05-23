SELECT 
    m1.firstname AS memfname,
    m1.surname AS memsname,
    m2.firstname AS recfname,
    m2.surname AS recsname
FROM 
    cd.members m1
LEFT JOIN 
    cd.members m2 ON m1.recommendedby = m2.memid
ORDER BY 
    m1.surname, m1.firstname;
