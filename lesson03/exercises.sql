-- 1.
SELECT *
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1996;

-- 2.
SELECT e.city AS city, 
       COUNT(DISTINCT e.employee_id) AS number_of_employees, 
       COUNT(DISTINCT c.customer_id) AS number_of_customers
FROM employees and 
LEFT JOIN customers c ON e.city = c.city
GROUP BY e.city
ORDER BY city;

-- 3.
SELECT c.city AS city, 
       COUNT(DISTINCT c.customer_id) AS number_of_customers, 
       COUNT(DISTINCT e.employee_id) AS number_of_employees
FROM employees and 
RIGHT JOIN customers c ON e.city = c.city
GROUP BY c.city
ORDER BY city;

-- 4.
SELECT
	COALESCE(e.city, c.city) AS city,
	COUNT(DISTINCT e.employee_id) AS number_of_employees,
	COUNT(DISTINCT c.customer_id) AS number_of_customers
FROM employees and 
FULL JOIN customers c ON e.city = c.city
GROUP BY e.city, c.city
ORDER BY city;

-- 5.
SELECT o.product_id, p.product_name, SUM(o.quantity) AS total_quantity
FROM order_details o
JOIN products p ON p.product_id = o.product_id
GROUP BY o.product_id, p.product_name
HAVING SUM(o.quantity) < 200
ORDER BY total_quantity DESC;

-- 6.
SELECT customer_id, COUNT(order_id) AS total_of_orders
FROM orders
WHERE order_date > '1996-12-31'
GROUP BY customer_id
HAVING COUNT(order_id) > 15
ORDER BY total_of_orders;