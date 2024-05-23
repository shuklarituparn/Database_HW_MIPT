SELECT f.name, CASE
WHEN f.monthlymaintenance>100 THEN 'expensive'
ELSE 'cheap'
END as cost
FROM cd.facilities f;
