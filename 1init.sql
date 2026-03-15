CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE areas (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE companies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    area_id INT REFERENCES areas(id)
);

CREATE TABLE vacancies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    area_id INT REFERENCES areas(id),
    specialization_id INT REFERENCES specializations(id),
    company_id INT REFERENCES companies(id),
    published_at TIMESTAMP NOT NULL,
    compensation_from NUMERIC CHECK (compensation_from >= 0),
    compensation_to NUMERIC CHECK (compensation_to >= 0 AND compensation_to >= compensation_from),
    status VARCHAR(50) DEFAULT 'active',
    experience_level VARCHAR(50),
    employment_type VARCHAR(50)
);

CREATE TABLE resumes (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    area_id INT REFERENCES areas(id),
    specialization_id INT REFERENCES specializations(id),
    published_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    salary_from NUMERIC CHECK (salary_from >= 0),
    salary_to NUMERIC CHECK (salary_to >= 0 AND salary_to >= salary_from),
    education TEXT
);

CREATE TABLE responses (
    id SERIAL PRIMARY KEY,
    vacancy_id INT REFERENCES vacancies(id),
    resume_id INT REFERENCES resumes(id),
    responded_at TIMESTAMP NOT NULL
);
