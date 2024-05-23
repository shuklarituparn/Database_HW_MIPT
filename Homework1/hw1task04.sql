SELECT
    id,
    (weight / 2.2046) / POWER((height * 0.0254), 2) AS bmi,
    CASE
        WHEN (weight / 2.2046) / POWER((height * 0.0254), 2) < 18.5 THEN 'underweight'
        WHEN (weight / 2.2046) / POWER((height * 0.0254), 2) < 25 THEN 'normal'
        WHEN (weight / 2.2046) / POWER((height * 0.0254), 2) < 30 THEN 'overweight'
        WHEN (weight / 2.2046) / POWER((height * 0.0254), 2) < 35 THEN 'obese'
        ELSE 'extremely obese'
    END AS type
FROM
    hw
ORDER BY
    bmi DESC,
    id DESC;
