--1
DROP DATABASE IF EXISTS lab_5;--вставка из-за ошибки при компиляции
CREATE DATABASE lab_5;

-- 2
DROP TABLE IF EXISTS customers; -- вставка из-за ошибки при компиляции
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS salesmen;

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    lastname VARCHAR(255),  -- Исправлено на lastname
    city VARCHAR(255),
    grade INTEGER,
    salesman_id INTEGER
);

CREATE TABLE orders (
    ord_no INTEGER PRIMARY KEY,
    purch_amt FLOAT,
    ord_date DATE,
    customer_id INTEGER,
    salesman_id INTEGER
);

CREATE TABLE salesmen (
    salesmen_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    commision FLOAT
);

INSERT INTO customers (customer_id, lastname, city, grade, salesman_id)
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

INSERT INTO salesmen (salesmen_id, name, city, commision)
VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', NULL, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

-- 3
SELECT SUM(purch_amt) AS total_purchase_amount
FROM orders;

-- 4
SELECT AVG(purch_amt) AS average_purchase_amount
FROM orders;

-- 5
SELECT COUNT(*) AS total_customers_with_names
FROM customers
WHERE lastname IS NOT NULL;

-- 6
SELECT MIN(purch_amt) AS minimum_purchase_amount
FROM orders;

-- 7
SELECT *
FROM customers
WHERE lastname LIKE '%b';

-- 8
SELECT *
FROM orders
WHERE customer_id IN (SELECT customer_id FROM customers WHERE city = 'New York');

-- 9
SELECT DISTINCT *
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders WHERE purch_amt > 10);

-- 10
SELECT SUM(grade) AS total_grade
FROM customers;

-- 11
SELECT *
FROM customers
WHERE lastname IS NOT NULL;

-- 12
SELECT MAX(grade) AS maximum_grade
FROM customers;
