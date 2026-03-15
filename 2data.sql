INSERT INTO specializations (name) SELECT 'Specialization ' || generate_series(1,50);


INSERT INTO areas (name) SELECT 'Region ' || generate_series(1,100);


INSERT INTO companies (name, area_id)
SELECT 
    'Company ' || generate_series(1,500),
    (floor(random()*100) + 1)::int;


INSERT INTO vacancies (
    title, description, area_id, specialization_id, company_id,
    published_at, compensation_from, compensation_to, status, experience_level, employment_type
)
SELECT
    'Vacancy ' || gs,
    'Description for vacancy ' || gs,
    (floor(random()*100)+1)::int,
    (floor(random()*50)+1)::int,
    (floor(random()*500)+1)::int,
    NOW() - (floor(random()*365)*INTERVAL '1 day'),
    comp_from,
    comp_from + (floor(random()*50000))::numeric AS compensation_to,
    CASE WHEN random() < 0.8 THEN 'active' ELSE 'closed' END,
    CASE 
        WHEN random()<0.25 THEN 'no_experience'
        WHEN random()<0.5 THEN '1-3'
        WHEN random()<0.75 THEN '3-6'
        ELSE '6+' 
    END,
    CASE 
        WHEN random()<0.7 THEN 'full-time'
        WHEN random()<0.85 THEN 'part-time'
        ELSE 'project'
    END
FROM (
    SELECT generate_series(1,10000) AS gs,
           (floor(random()*100000)+20000)::numeric AS comp_from
) sub;


INSERT INTO resumes (
    title, area_id, specialization_id, published_at, updated_at, salary_from, salary_to, education_level
)
SELECT
    'Resume ' || gs,
    (floor(random()*100)+1)::int,
    (floor(random()*50)+1)::int,
    NOW() - (floor(random()*365)*INTERVAL '1 day'),
    NOW() - (floor(random()*365)*INTERVAL '1 day'),
    sal_from,
    sal_from + (floor(random()*50000))::numeric AS salary_to,
    CASE
        WHEN random()<0.25 THEN 'secondary'
        WHEN random()<0.6 THEN 'bachelor'
        WHEN random()<0.9 THEN 'master'
        ELSE 'phd'
    END
FROM (
    SELECT generate_series(1,100000) AS gs,
           (floor(random()*100000)+20000)::numeric AS sal_from
) sub;


INSERT INTO responses (vacancy_id, resume_id, responded_at)
SELECT 
    (floor(random()*10000)+1)::int,
    (floor(random()*100000)+1)::int,
    NOW() - (floor(random()*30)*INTERVAL '1 day')
FROM generate_series(1,50000) gs;