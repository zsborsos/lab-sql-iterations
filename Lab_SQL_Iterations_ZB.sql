-- Lab | SQL Iterations
-- Zsanett Borsos

-- Write a query to find what is the total business done by each store.
SELECT sakila.staff.store_id, SUM(sakila.payment.amount) AS 'Total sales' FROM sakila.staff
JOIN sakila.payment ON
sakila.staff.staff_id = sakila.payment.staff_id
GROUP BY sakila.staff.store_id;

-- Convert the previous query into a stored procedure.
DELIMITER //
CREATE PROCEDURE total_business()
BEGIN
SELECT sakila.staff.store_id, SUM(sakila.payment.amount) AS 'Total sales' FROM sakila.staff
JOIN sakila.payment ON
sakila.staff.staff_id = sakila.payment.staff_id
GROUP BY sakila.staff.store_id;
END //
DELIMITER ;
CALL total_business;

-- Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.
DELIMITER //
CREATE PROCEDURE total_business_by_store(IN parameter int)
BEGIN
SELECT sakila.staff.store_id, SUM(sakila.payment.amount) AS 'Total sales' FROM sakila.staff
JOIN sakila.payment ON
sakila.staff.staff_id = sakila.payment.staff_id
WHERE sakila.staff.store_id=parameter
GROUP BY sakila.staff.store_id;
END //
DELIMITER ;
CALL total_business_by_store(1);

-- Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result 
-- (of the total sales amount for the store). Call the stored procedure and print the results.
DELIMITER //
CREATE PROCEDURE total_business_by_store2(IN parameter int)
BEGIN
DECLARE total_business_by_store2 FLOAT DEFAULT 0;
SELECT sakila.staff.store_id, SUM(sakila.payment.amount) AS 'Total sales' FROM sakila.staff
JOIN sakila.payment ON
sakila.staff.staff_id = sakila.payment.staff_id
WHERE sakila.staff.store_id=parameter
GROUP BY sakila.staff.store_id;
END //
DELIMITER ;
CALL total_business_by_store2(1);

-- In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, 
-- otherwise label is as red_flag. Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.
DELIMITER //
CREATE PROCEDURE total_business_by_store_flag(IN parameter INT)
BEGIN
SELECT sakila.staff.store_id, SUM(sakila.payment.amount) AS 'Total sales',
CASE
WHEN SUM(sakila.payment.amount) > 30000 then "Green flag"
ELSE 'Green flag' END AS flag
FROM sakila.staff
JOIN sakila.payment ON
sakila.staff.staff_id = sakila.payment.staff_id
WHERE sakila.staff.store_id=parameter
GROUP BY sakila.staff.store_id;
END //
DELIMITER ;
CALL total_business_by_store_flag(2);


