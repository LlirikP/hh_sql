WITH 
vacancy_counts AS (
    SELECT 
        TO_CHAR(published_at, 'Month') AS month_name,
        COUNT(*) AS count_vacancies
    FROM vacancies
    GROUP BY month_name
),
resume_counts AS (
    SELECT 
        TO_CHAR(published_at, 'Month') AS month_name,
        COUNT(*) AS count_resumes
    FROM resumes
    GROUP BY month_name
)
SELECT 
    vac_month.month_name AS most_vacancies_month,
    vac_month.count_vacancies,
    res_month.month_name AS most_resumes_month,
    res_month.count_resumes
FROM 
    (SELECT 
        month_name,
        count_vacancies
     FROM vacancy_counts
     ORDER BY count_vacancies DESC
     LIMIT 1) vac_month
CROSS JOIN
    (SELECT 
        month_name,
        count_resumes
     FROM resume_counts
     ORDER BY count_resumes DESC
     LIMIT 1) res_month;