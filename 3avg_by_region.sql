SELECT
    area_id,
    ROUND(AVG(compensation_from), 2) AS avg_compensation_from,
    ROUND(AVG(compensation_to), 2) AS avg_compensation_to,
    ROUND(AVG((compensation_from + compensation_to)/2), 2) AS avg_compensation_both
FROM vacancies
GROUP BY area_id;