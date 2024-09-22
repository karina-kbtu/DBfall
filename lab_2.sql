CREATE DATABASE lab2;--1
--2
CREATE TABLE countries(
    country_id SERIAL PRIMARY KEY ,
    country_name VARCHAR(255) DEFAULT 'Kazakstan',--7
    region_id INTEGER,
    population INTEGER
);
--3
INSERT INTO countries(country_name, region_id, population)
VALUES('USA',15,20000000);
--4
INSERT INTO countries(country_id,country_name)
VALUES(69,'Namibia');
--5
INSERT INTO countries (country_name, region_id, population)
VALUES ('Mexico', NULL, 128000000);
--6
INSERT INTO countries(country_name, region_id, population)
VALUES
('Russia', 1,5000000000),
('France',5,400000000),
('Germany',7,709009898);
--8
INSERT INTO countries (region_id, population)
VALUES (3, 19000000);
--9
INSERT INTO countries DEFAULT VALUES;
--10
CREATE TABLE countries_new (LIKE countries INCLUDING ALL);
--11
INSERT INTO countries_new
SELECT * FROM countries;
--12
UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;
--13
SELECT country_name,
       population * 1.1 AS "New Population"
FROM countries;
--14
DELETE FROM countries
WHERE population < 100000;
--15
DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;
--16
DELETE FROM countries
RETURNING *;
