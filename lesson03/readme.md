# Class 03 - SQL for Analytics: Joining and Having in SQL

## Introduction to Joins in SQL

Joins in SQL are fundamental for combining records from two or more tables in a database based on a common condition, usually a foreign key. This technique allows related data, which are stored in separate tables, to be queried together in an efficient and coherent way. 

Joins are essential for querying complex data and for applications in which database normalization results in the distribution of information across several tables.

There are several types of joins, each with its specific use depending on the needs of the query:

1. **Inner Join**: Returns records that match in both tables.
2. **Left Join (or Left Outer Join)**: Returns all records from the left table and the corresponding records from the right table. If there is no match, the results in the right table will have `NULL` values.
3. **Right Join (or Right Outer Join)**: Returns all records from the right table and the corresponding records from the left table. If there is no match, the results in the left table will have `NULL` values.
4. **Full Join (or Full Outer Join)**: Returns records when there is a match in one of the tables. If there is no match, the result will still appear with `NULL` in the unmatched table fields.

### 1. Create a report for all orders from 1996 and your customers

**Inner Join**

**Use**: Used when you need records that have an exact match in both tables.

**Practical Example**: If we want to find all orders from 1996 and the details of the customers who placed these orders, we use an Inner Join. This ensures that we only get orders that have a matching customer and were placed in 1996.

```sql
-- Creates a report for all 1996 orders and their customers (152 lines)
SELECT *
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1996; -- EXTRACT(part FROM date) part can be YEAR, MONTH, DAY, etc.
```

Gustavo also brought this implementation

'WHERE DATE_PART('YEAR', o.order_date) = 1996'

In SQL server you can use 

'WHERE YEAR(o.order_date) = 1996'

In the context of your query, the use of EXTRACT in the WHERE clause is specifically to apply a filter to the data returned by SELECT, ensuring that only records from the year 1996 are included in the result set. This is a legitimate and common use of EXTRACT for handling date-based conditions within WHERE clauses.

### 2. Create a report that shows the number of employees and customers in each city that has employees

**Left Join**

**Use**: Used when you want all records from the first (left) table, with the corresponding records from the second (right) table. If there is no match, the second table will have `NULL` fields. 

**Practical Example**: If we need to list all the cities where we have employees, and we also want to know how many customers we have in those cities, even if there are no customers, we use a Left Join.

```sql
-- Creates a report that shows the number of employees and customers for each city that has employees (5 lines)
SELECT e.city AS city, 
       COUNT(DISTINCT e.employee_id) AS number_of_employees, 
       COUNT(DISTINCT c.customer_id) AS number_of_customers
FROM employees and 
LEFT JOIN customers c ON e.city = c.city
GROUP BY e.city
ORDER BY city;
```

### Example of Query Results

| city ​​| number_of_employees | number_of_customers |
| --- | --- | --- |
| Kirkland | 1 | 1 |
| London | 4 | 6 |
| Redmond | 1 | 0 |
| Seattle | 2 | 1 |
| Tacoma | 1 | 0 |

### Table Description

* **city**: The name of the city where employees and customers are located.
* **number_of_staff**: Count of different employees in this city. This number comes directly from the `employees` table.
* **number_of_customers**: Count of different customers who have the same city as the employees. If there are no customers in a city where there are employees, the number will be 0.

### Detailed Explanation

* **Kirkland**: Has a balance between the number of employees and customers, with both values ​​being 1. This indicates a direct match between employee and customer locations.
* **London**: It has a greater concentration of both employees and customers, with more customers (6) than employees (4), indicating a strong presence of both in the city.
* **Redmond**: Has 1 employee, but no registered customers in this city, suggesting that, although the company has a work presence here, there are no registered customers.
* **Seattle**: Has 2 employees and only 1 customer, showing a smaller presence of customers in relation to employees.
* **Tacoma**: Similar to Redmond, has employees (1) but no customers, which may indicate an area where the company operates but has not yet established a customer base.

This analysis is particularly useful for understanding how the company's human resources (employees) are distributed in relation to its customer base in different locations. This can help identify cities where the company may need to step up customer acquisition efforts or assess the effectiveness of its local market operations and strategies.


### 3. Create a report that shows the number of employees and customers in each city that has customers

**Right Join**

**Use**: It is the opposite of Left Join and is less common. Used when we want all records from the second (right) table and the corresponding records from the first (left) table.

**Practical Example**: To list all the cities where we have customers, and also count how many employees we have in these cities, we use a Right Join.

```sql
-- Creates a report that shows the number of employees and customers for each city that has customers (69 lines)
SELECT c.city AS city, 
       COUNT(DISTINCT c.customer_id) AS number_of_customers, 
       COUNT(DISTINCT e.employee_id) AS number_of_employees
FROM employees and 
RIGHT JOIN customers c ON e.city = c.city
GROUP BY c.city
ORDER BY city;
```

### Main Differences from `RIGHT JOIN`

1. **Focus on Right Table**: Unlike `LEFT JOIN` which focuses on the left table, `RIGHT JOIN` ensures that all records from the right table (in this case, `customers`) are present in the result. If there is no match in the left table (`employees`), related columns from this table will appear as `NULL`.
    
2. **Displaying Unmatched Data**: As shown, `RIGHT JOIN` can display rows where there is no match in the left table, which is useful for identifying data that is only in the right table. In the context of a business, this can highlight areas (or data) that require attention, such as customers in locations where the company does not have employees represented.
    
3. **Strategic Use for Data Analysis**: `RIGHT JOIN` is less common than `LEFT JOIN` because tables are often organized so that the most important (or comprehensive) table is placed to the left of the consultation. However, `RIGHT JOIN` is useful when the table on the right is priority and we want to ensure that all its records are parsed.


### 4. Create a report that shows the number of employees and customers in each city

* **Full Data Analysis**: `FULL JOIN` is useful when you need a complete view of the data in two related tables, especially to identify where data is missing in one or both tables.
* **Comprehensive Reports**: Allows you to create reports that show all possible relationships between two tables, including where relationships do not exist.
* **Data Gap Analysis**: Helps identify gaps in data from both tables simultaneously, facilitating coverage and consistency analysis between data sets.

**Full Join**

**Use**: Used when we want the union of Left Join and Right Join, showing all records from both tables, and filling with `NULL` where there is no match.

**Practical Example**: To list all cities where we have customers or employees, and count both in each city, we use a Full Join.

```sql
-- Creates a report that shows the number of employees and customers in each city (71 lines)
SELECT
	COALESCE(e.city, c.city) AS city,
	COUNT(DISTINCT e.employee_id) AS number_of_employees,
	COUNT(DISTINCT c.customer_id) AS number_of_customers
FROM employees and 
FULL JOIN customers c ON e.city = c.city
GROUP BY e.city, c.city
ORDER BY city;
```

This query returns a list of all cities known to both tables, along with the employee and customer count in each city. Here are some possible scenarios in the outcome:

### Result Analysis

The result of the `FULL JOIN` shows:

*Most cities listed have customers but not employees (indicated by "0" in the number of employees).
* In some cities, such as "Kirkland", "Redmond", "Seattle", and "Tacoma", there are employees and/or customers, showing direct correspondence between the tables.
* Notably, in cities such as "London" and "Madrid", the number of customers is significantly greater than the number of employees, which may indicate centers of high customer activity without a corresponding proportion of employee support.

### Important Notes

1. **Cities with only Customers**: Most cities in the result have customers, but not employees. This may suggest that the company has a broad customer base geographically but a more limited distribution of its workforce.
    
2. **Cities with Employees and No Customers**: Cities such as "Redmond" and "Tacoma" have employees but no customer counts listed, indicating that there are company operations without corresponding customer activity recorded in those locations.
    
3. **Customer and Employee Concentrations**: In cities such as "London", "Seattle", and "Sao Paulo", there is a significant concentration of customers and some presence of employees, suggesting operational centers or important markets for the company .
    
4. **Missing Data in Some Cities**: Some cities have zero employees and customers, indicating that there may be a data error, cities listed incorrectly, or simply that there is no employee or customer activity registered in those locations.
    

### Strategic Implications

Based on this data, the company could consider several strategic actions:

* **Employee Expansion**: Invest in human resources in cities with high customer numbers but low employee presence to improve customer support and satisfaction.
    
* **Market Analysis**: Perform a more in-depth analysis on why certain cities have high customer activity and adjust marketing and sales strategies as necessary.
    
* **Data Review**: Verify data accuracy to better understand discrepancies or absences in employee and customer counts.
    
This example highlights the value of using `FULL JOIN` to get a complete view of the relationship between two critical variables (employees and customers) and how this information can be used for strategic insights.

##Having

### 1. Create a report that shows the total quantity of products (from the order_details table)

```sql
-- Creates a report that shows the total quantity of products ordered.
-- Shows only records for products for which the ordered quantity is less than 200 (5 lines)
SELECT o.product_id, p.product_name, SUM(o.quantity) AS total_quantity
FROM order_details o
JOIN products p ON p.product_id = o.product_id
GROUP BY o.product_id, p.product_name
HAVING SUM(o.quantity) < 200
ORDER BY total_quantity DESC;
```

### 2. Create a report that shows total orders by customer since December 31, 1996

```sql
-- Creates a report that shows total orders per customer since December 31, 1996.
-- The report should only return rows for which total orders are greater than 15 (5 rows)
SELECT customer_id, COUNT(order_id) AS total_of_orders
FROM orders
WHERE order_date > '1996-12-31'
GROUP BY customer_id
HAVING COUNT(order_id) > 15
ORDER BY total_of_orders;
```

### Explanation of Converted Queries

**Query 1:**

* **Selection and Join**: The query selects the `product_id` and `product_name` from the `products` table and joins them with the `order_details` table by `product_id`.
* **Grouping and Filtering**: Data is grouped by `product_id` and `product_name`, and the aggregate function `SUM(o.quantity)` calculates the total quantity of each product ordered. The `HAVING` clause is used to filter products whose total ordered quantity is less than 200.

**Query 2:**

* **Date Filtering**: The query filters orders made after December 31, 1996.
* **Grouping and Counting**: Groups orders by `customer_id` and counts the number of orders placed by each customer using `COUNT(order_id)`.
* **Result Filtering**: Uses the `HAVING` clause to only include customers who have placed more than 15 orders since the specified date.