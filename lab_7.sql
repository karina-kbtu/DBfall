--1
CREATE INDEX index_countries_name ON countries(name);
--2
CREATE INDEX index_employees_surname ON employees(name,surname);
--3
CREATE UNIQUE INDEX index_employees_salary_range ON employees(salary);
--4
CREATE INDEX index_employees_name_substring ON employees((substring(name FROM 1 FOR 4)));
--5
CREATE INDEX index_employees_departments_budget_salary ON employees(department_id,salary);
CREATE INDEX index_departments_budget ON departments(budget);

CREATE INDEX idx_employees_departments_budget_salary
ON employees (department_id, salary), departments (budget);


