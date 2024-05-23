WITH ranked_days AS (
    SELECT SUM(vol) as vol, dt
    FROM coins GROUP BY dt
)
SELECT RANK() OVER(ORDER BY vol DESC), dt, vol FROM ranked_days LIMIT(10)
