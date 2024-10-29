--1
DROP DATABASE IF EXISTS lab_6;

CREATE DATABASE lab_6;
--2
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS locations;

CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY ,
    street_address VARCHAR(25) ,
    postal_code VARCHAR(12) ,
    city VARCHAR(30) ,
    state_province VARCHAR (12)
);
CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY ,
    department_name VARCHAR(50) UNIQUE ,
    budget INTEGER ,
    location_id INTEGER REFERENCES locations
);
CREATE TABLE employees(
  employee_id SERIAL PRIMARY KEY ,
  first_name VARCHAR(50) ,
  last_name VARCHAR(50) ,
  email VARCHAR(50) ,
  phone_number VARCHAR(20) ,
  salary INTEGER ,
  department_id  INTEGER REFERENCES departments
);
INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
('123 Main St', '12345', 'New York', 'NY'),
('456 Elm St', '67890', 'Los Angeles', 'CA'),
('789 Maple Ave', '11223', 'Chicago', 'IL'),
('101 Oak Dr', '33445', 'Houston', 'TX'),
('202 Pine St', '55667', 'Phoenix', 'AZ');

INSERT INTO departments (department_name, budget, location_id) VALUES
('Human Resources', 50000, 1),
('Sales', 200000, 2),
('IT', 150000, 3),
('Marketing', 100000, 4),
('Finance', 120000, 5);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('John', 'Doe', 'jdoe@example.com', '555-1234', 60000, 1),
('Jane', 'Smith', 'jsmith@example.com', '555-5678', 70000, 2),
('Mike', 'Johnson', 'mjohnson@example.com', '555-8765', 80000, 3),
('Emily', 'Davis', 'edavis@example.com', '555-4321', 55000, 4),
('Chris', 'Brown', 'cbrown@example.com', '555-1357', 62000, 5),
('Sarah', 'Wilson', 'swilson@example.com', '555-2468', 75000, 2),
('Tom', 'Harris', 'tharris@example.com', '555-9753', 67000, 3),
('Laura', 'Martinez', 'lmartinez@example.com', '555-8642', 59000, 1);

--3
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

--4
SELECT e.first_name, e.last_name, e.department_id, d.department_id
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IN (80,40);

--5
SELECT e.first_name, e.last_name, d.department_id, l.city, l.state_province
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;

--6
SELECT d.department_name, d.department_id
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id;

--7
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;
