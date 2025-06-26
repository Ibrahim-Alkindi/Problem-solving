use sales;

-- 1. Count the Number of Customers
SELECT COUNT(customer_id) AS 'Number of Customers' FROM customers;

-- 2. Sum of All Orders' Quantities
SELECT SUM(quantity) AS 'Sum of Orders' FROM order_items;

SELECT order_date AS 'Date Of the Order', SUM(quantity) AS 'Sum of Orders' FROM order_items oi
JOIN orders o ON (oi.order_id = o.order_id)
WHERE order_date >= '2017-01-01'
GROUP BY order_date
HAVING SUM(quantity) < 500
ORDER BY order_date DESC;

-- 3. Average List Price of Products
SELECT AVG(list_price) AS 'Average List Price of Products' FROM Products;

-- 4. Maximum Credit Limit of Customers
SELECT MAX(credit_Limit) AS 'Maximum Credit Limit' FROM Customers;

-- 5. Minimum Quantity in Inventories
SELECT MIN(quantity) AS 'Minimum Quantity' FROM Inventories;

-- 6. Group by Example: Total Sales by Status
SELECT Status, SUM(quantity * unit_price) AS 'Total Orders'FROM orders o
JOIN order_items oi ON(o.order_id = oi.order_id)
GROUP BY Status;

-- 7. Group by with Having Clause: Products with Total Quantity Greater Than 1000
SELECT product_name AS 'Product Name', SUM(quantity) AS 'Total Quantity' FROM products p
JOIN order_items oi ON (p.product_id = oi.order_id)
GROUP BY product_name
HAVING  SUM(quantity) > 1000;

-- 8. Number of Employees Grouped by Job Title
SELECT  job_title, COUNT(*) AS 'Number of Employees' FROM employees 
GROUP BY job_title;

-- 9. Total Number of Warehouses by Country
SELECT c.country_name AS 'Country Name', COUNT(w.warehouse_id) AS 'Number of warehouses'
FROM warehouses w
JOIN locations l ON (w.location_id = l.location_id)
JOIN countries c ON (l.country_id = c.country_id)
GROUP BY c.country_name;

-- 10. Total Revenue from All Orders
SELECT SUM(quantity * unit_price) AS 'Total Revenue'FROM order_items;


-- ---- 
-- 1. List All Orders with Customer Information
-- 2. Find All Products with Their Categories
-- 3. Get Employee Details Along with Their Manager's Name
-- 4. List All Customers and Their Contacts
-- 5. Find Products Available in Specific Warehouses
-- 6. Get the Total Number of Orders by Each Salesman
-- 7. List Locations and the Number of Warehouses in Each City
-- 8. Get All Orders and Their Status with Customer and Salesman DetaSils
-- 9. Find Regions and the Number of Countries in Each Region
-- 10. List Employees Working in a Specific Location
