--1
DROP DATABASE IF EXISTS lab_8;
CREATE DATABASE lab_8;
--2
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS salesmen;
CREATE TABLE salesmen (
    salesmen_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    commision FLOAT
);
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INTEGER,
    salesman_id INTEGER REFERENCES salesmen(salesmen_id)
);

CREATE TABLE orders (
    ord_no INTEGER PRIMARY KEY,
    purch_amt FLOAT,
    ord_date DATE,
    customer_id INTEGER REFERENCES customers(customer_id),
    salesman_id INTEGER REFERENCES salesmen(salesmen_id)
);
INSERT INTO salesmen (salesmen_id, name, city, commision)
VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', NULL, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);
--4
CREATE VIEW salesmen_new_york AS
SELECT *
FROM salesmen
WHERE city = 'New York';
--5 part a
CREATE VIEW order_details AS
SELECT
    o.ord_no,
    o.purch_amt,
    o.ord_date,
    s.name AS salesman_name,
    c.cust_name AS customer_name
FROM orders o
JOIN salesmen s ON o.salesman_id = s.salesmen_id
JOIN customers c ON o.customer_id = c.customer_id;
--6 part a
CREATE VIEW highest_grade_customers AS
SELECT *
FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);
--7
CREATE VIEW salesmen_count_by_city AS
SELECT
    city,
    COUNT(*) AS number_of_salesmen
FROM salesmen
GROUP BY city;
--8
CREATE VIEW salesmen_with_multiple_customers AS
SELECT
    s.salesmen_id,
    s.name AS salesman_name,
    COUNT(c.customer_id) AS number_of_customers
FROM salesmen s
JOIN customers c ON s.salesmen_id = c.salesman_id
GROUP BY s.salesmen_id, s.name
HAVING COUNT(c.customer_id) > 1;

--3
CREATE ROLE junior_dev WITH LOGIN PASSWORD 'password';

--5 part b
GRANT ALL PRIVILEGES ON TABLE  order_details TO junior_dev;
--6 part b
GRANT SELECT ON TABLE highest_grade_customers TO junior_dev;
--9
CREATE ROLE intern;
GRANT junior_dev TO intern;