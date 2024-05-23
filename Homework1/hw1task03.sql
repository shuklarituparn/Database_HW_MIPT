
SELECT
    count(*) AS underweight_count
FROM
    hw
WHERE (weight / 2.2046) / POWER((height * 0.0254), 2)<18.5;

