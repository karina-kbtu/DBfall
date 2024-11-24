--1
CREATE OR REPLACE FUNCTION increase_value(input_value INT)
RETURNS INT AS $$
BEGIN
    RETURN input_value + 10;
END;
    $$ LANGUAGE plpgsql;


--2
CREATE OR REPLACE FUNCTION compare_numbers(num1 INT,num2 INT, OUT RESULT TEXT)
AS $$
BEGIN
    IF num1 > num2 THEN
        result := 'Greater';
    ELSEIF num1 = num2 THEN
        result := 'Equal';
    ELSE
        result := 'Lesser';
    END IF;
END;
    $$ LANGUAGE plpgsql;


--3
CREATE OR REPLACE FUNCTION number_series(n INT)
RETURNS TABLE(series INT) AS $$
BEGIN
    FOR series IN 1..n LOOP
        RETURN NEXT series;
    END LOOP;
END;
    $$ LANGUAGE plpgsql;


--4
CREATE OR REPLACE FUNCTION find_employee(employee_name VARCHAR)
RETURNS TABLE(id INT, name VARCHAR, position VARCHAR, department VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT id,name,position,department
    FROM employees
    WHERE name = employee_name;
END;
    $$ LANGUAGE plpgsql;


--5
CREATE OR REPLACE FUNCTION list_procedure(category_name VARCHAR)
RETURNS TABLE(product_id INT, product_name VARCHAR, price NUMERIC) AS $$
BEGIN
   RETURN QUERY
    SELECT product_id,product_name,price
    FROM products
    WHERE category = category_name;
END;
    $$ LANGUAGE plpgsql;


--6
--first procedure
CREATE OR REPLACE FUNCTION calculate_bonus(employee_id INT)
RETURNS NUMERIC AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    SELECT salary * 0.1 INTO bonus
    FROM employees
    WHERE id = employee_id;
    RETURN bonus;
END;
    $$ LANGUAGE plpgsql;

--second procedure
CREATE OR REPLACE FUNCTION update_salry(employee_id INT)
RETURNS VOID AS $$
DECLARE
    bonus NUMERIC;
BEGIN
   bonus := calculate_bonus(employee_id);

   UPDATE employees
    SET salary = salary + bonus
    WHERE id = employee_id;
END;
    $$ LANGUAGE plpgsql;


--7
CREATE OR REPLACE FUNCTION complex_calculation(num_input INT, text_input VARCHAR)
RETURNS TEXT AS $$
DECLARE
    numeric_result INT;
    string_result TEXT;
BEGIN
    --subblock 1 - numeric computation
    <<num_blocK>>
    BEGIN
        numeric_result := num_input * 2;
    END num_blocK;

    --subblock 2 - string mnipulation
    <<str_block>>
    BEGIN
        string_result := text_input || 'processed';
    END str_block;

    --main block - combine results
    RETURN 'Calculation: ' || numeric_result || ', ' || string_result;
END;
    $$ LANGUAGE plpgsql;

--usage example
--1 SELECT increase_value(5);
--2 SELECT compare_numbers(10, 20) AS result;
--3 SELECT * FROM number_series(5);
--4 SELECT * FROM find_employee('John Doe');
--5 SELECT * FROM list_products('Electronics');
--6 CALL update_salary(1);
--7SELECT complex_calculation(10, 'Example Text');