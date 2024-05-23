SELECT 
    CONCAT(m1.firstname, ' ', m1.surname) AS member,
    CASE
        WHEN m2.memid IS NOT NULL THEN CONCAT(m2.firstname, ' ', m2.surname)
        ELSE NULL
    END AS recommender
FROM 
    cd.members m1
LEFT JOIN 
    cd.members m2 ON m1.recommendedby = m2.memid
ORDER BY 
    member;
