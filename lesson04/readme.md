# Class 04 - Windows Function

Postgres documentation: https://www.postgresql.org/docs/current/functions-window.html

## With what we've seen so far: Group By

With the SQL we've seen so far we get two types of results: all lines (with or without filter/where) or grouped lines (group by)

Calculate:
How many unique products are there?
How many products in total?
What is the total amount paid?

```sql
SELECT order_id,
       COUNT(order_id) AS unique_product,
       SUM(quantity) AS total_quantity,
       SUM(unit_price * quantity) AS total_price
FROM order_details
GROUP BY order_id
ORDER BY order_id;
```

## With Windows Function

`Windows Function` enable efficient and accurate data analysis, by enabling calculations within `specific partitions or rows`. They are crucial for tasks such as sorting, aggregation, and trend analysis in SQL queries.

These functions are applied to each row of a result set, and use an `OVER()` clause to determine how each row is processed within a "window", allowing control over the behavior of the function within a group of ordered data. .

Window Functions Syntax components
```sql
window_function_name(arg1, arg2, ...) OVER (
  [PARTITION BY partition_expression, ...]
  [ORDER BY sort_expression [ASC | DESC], ...]
)
```

* **window_function_name**: This is the name of the window function you want to use, such as SUM, RANK, LEAD, etc.

* **arg1, arg2, ...:** These are the arguments you pass to the window function, if it requires any. For example, for the SUM function, you would specify the column you want to sum.

* **OVER**: Main concept of windows functions, it creates this "Window" where we do our calculations

* **PARTITION BY:** This optional clause divides the result set into partitions or groups. The window function operates independently within each partition.

* **ORDER BY:** This optional clause specifies the order in which rows are processed within each partition. You can specify ascending (ASC) or descending (DESC) order.

```sql
SELECT DISTINCT order_id,
   COUNT(order_id) OVER (PARTITION BY order_id) AS unique_product,
   SUM(quantity) OVER (PARTITION BY order_id) AS total_quantity,
   SUM(unit_price * quantity) OVER (PARTITION BY order_id) AS total_price
FROM order_details
ORDER BY order_id;
```

## MIN(), MAX(), AVG()

What are the minimum, maximum and average shipping costs paid by each customer? (orders table)

### Using Group by

```sql
SELECT customer_id,
   MIN(freight) AS min_freight,
   MAX(freight) AS max_freight,
   AVG(freight) AS avg_freight
FROM orders
GROUP BY customer_id
ORDER BY customer_id;
```

### Adjusted Query Details:

* **`customer_id`**: Selects the unique customer identifier from the `orders` table.
* **`MIN(freight) AS min_freight`**: Calculates the minimum shipping value for each customer.
* **`MAX(freight) AS max_freight`**: Calculates the maximum shipping value for each customer.
* **`AVG(freight) AS avg_freight`**: Calculates the average shipping cost for each customer.

### Explanation:

* The `MIN` function extracts the lowest shipping value recorded for each customer.
* The `MAX` function obtains the highest shipping value recorded for each customer.
* The `AVG` function provides the average shipping value per customer, useful for understanding the average shipping cost associated with each one.
* `GROUP BY customer_id` groups records by `customer_id`, allowing aggregate functions to calculate their results for each customer group.
* `ORDER BY customer_id` ensures that results are presented in ascending order of `customer_id`, making data easier to read and analyze.

### Using Windows Function

```sql
SELECT DISTINCT customer_id,
   MIN(freight) OVER (PARTITION BY customer_id) AS min_freight,
   MAX(freight) OVER (PARTITION BY customer_id) AS max_freight,
   AVG(freight) OVER (PARTITION BY customer_id) AS avg_freight
FROM orders
ORDER BY customer_id;
```

### Explanation of the Adjusted Query:

* **`customer_id`**: Selects the unique customer identifier from the `orders` table.
* **`MIN(freight) OVER (PARTITION BY customer_id)`**: Uses the `MIN` window function to calculate the minimum shipping value for each group of records that have the same `customer_id`.
* **`MAX(freight) OVER (PARTITION BY customer_id)`**: Uses the `MAX` window function to calculate the maximum shipping amount for each `customer_id`.
* **`AVG(freight) OVER (PARTITION BY customer_id)`**: Uses the `AVG` window function to calculate the average shipping value for each `customer_id`.

### Features of Window Functions:

* **Window Functions (`OVER`)**: Window functions allow you to perform calculations over a set of rows related to each input. When using `PARTITION BY customer_id`, the window function is restarted for each new `customer_id`. This means that each calculation of `MIN`, `MAX`, and `AVG` is confined to the order set of each individual client.
* **`DISTINCT`**: The `DISTINCT` clause is used to ensure that each `customer_id` appears only once in the final results, along with their respective minimum, maximum and average shipping values. This is necessary because window functions calculate values ​​for each row, and without `DISTINCT`, each `customer_id` could appear multiple times if there are multiple orders per customer.

## Collapse

To illustrate how the `GROUP BY` clause influences the results of an SQL query and why it can "collapse" rows to a single row per group, I will give an example based on the aggregation functions `MIN`, `MAX`, and `AVG` which we discussed earlier. These functions are often used to calculate summary statistics within each group specified by `GROUP BY`.

### Example without GROUP BY

Consider the following query without using `GROUP BY`:

```sql 
-- 830 lines
SELECT customer_id, freight
FROM orders;
```

This query simply selects the `customer_id` and `freight` for each order. If there are multiple orders for each customer, each order appears as a separate line in the result set.

### Example with GROUP BY

Now, let's add `GROUP BY` and aggregation functions:

```sql
-- 89 lines
SELECT customer_id,
       MIN(freight) AS min_freight,
       MAX(freight) AS max_freight,
       AVG(freight) AS avg_freight
FROM orders
GROUP BY customer_id
ORDER BY customer_id;
```

### What happens here:

* **`GROUP BY customer_id`**: This clause groups all entries in the `orders` table that have the same `customer_id`. For each group, the query calculates the minimum, maximum and average `freight` values.
    
* **Aggregations (`MIN`, `MAX`, `AVG`)**: Each of these aggregation functions operates on the set of `freight` within the group specified by `customer_id`. Only one value for each aggregate function is returned per group.
    

### Why "collapses" the lines:

* When we use `GROUP BY`, the query no longer returns a row for each entry in the `orders` table. Instead, it returns one row for each `customer_id` group, where each row contains the `customer_id` and aggregated `freight` values ​​for that group. This means that if a customer has multiple orders, you will not see each order individually; Instead, you'll see a summary line with shipping statistics for all orders from that customer.

### Limitation of SELECT with GROUP BY:

* If you try to select a column that is not included in the `GROUP BY` clause and that is not an aggregate expression, the query will fail. For example, the following query will result in an error because `order_date` is not in an aggregate function or in `GROUP BY`:

```sql
SELECT customer_id, order_date, AVG(freight) AS avg_freight
FROM orders
GROUP BY customer_id;
```

### Typical Error Message:

* In many database management systems, such as PostgreSQL or MySQL, this query would result in an error like: "column "orders.order_date" must appear in the GROUP BY clause or be used in an aggregate function".

This example clearly shows how `GROUP BY` "collapses" rows into groups, allowing summary calculations, but also imposing restrictions on which columns can be selected directly.

To illustrate how to avoid "collapse" of lines using window functions instead of `GROUP BY`, we will use the same shipping statistics (minimum, maximum and average) per customer, but keep all order lines visible in the result set. Windowing functions allow you to calculate aggregations while still keeping each row distinct in the output.

### Query with Window Functions

Here's how you can write a query that uses window functions to calculate the minimum, maximum, and average shipping for each customer without collapsing the rows:

```sql
SELECT 
    customer_id,
    order_id, -- Maintaining visibility of each order
    freight,
    MIN(freight) OVER (PARTITION BY customer_id) AS min_freight,
    MAX(freight) OVER (PARTITION BY customer_id) AS max_freight,
    AVG(freight) OVER (PARTITION BY customer_id) AS avg_freight
FROM orders
ORDER BY customer_id, order_id;
```

### Query Explanation

* **Column Selection**: `customer_id`, `order_id`, and `freight` are selected directly, which keeps each individual order line visible in the result.
* **Window Functions**: `MIN(freight) OVER`, `MAX(freight) OVER`, and `AVG(freight) OVER` are applied with the `PARTITION BY customer_id` clause. This means that shipping statistics are calculated for each `customer_id` group, but the application is done without grouping the rows into a single result per customer. Each row in the original result set maintains its unique identity.
* **`PARTITION BY customer_id`**: Ensures that window functions are recalculated for each customer. Each order retains its line, but now also includes aggregated shipping information specific to the customer the order belongs to.
* **`ORDER BY customer_id, order_id`**: Orders the results first by `customer_id` and then by `order_id`, making the data easier to read.

### Advantages of Window Functions

* **Detailed Data Preservation**: Unlike `GROUP BY`, which aggregates and collapses data to one row per group, window functions keep each individual row of the original dataset visible. This is useful for detailed analysis where you need to see both aggregated values ​​and individual row data.
* **Flexibility**: You can calculate multiple aggregation metrics across different partitions within the same query without multiple data passes or complex subqueries.

This method is especially useful in detailed reporting and analysis where both the aggregated context and the details of each individual event (in this case, each order) are important for a complete understanding of the data.

Window sort functions in SQL are a set of valuable tools used to assign ranks, positions, or sequential numbers to rows within a result set based on specific criteria.

They are applied in various scenarios, such as creating leaderboards, classifying products by sales, identifying top performers or tracking changes over time. These functions are powerful tools for gaining insights and making informed decisions in data analysis.

### 2.1 RANK(), DENSE_RANK() and ROW_NUMBER()

* **RANK()**: Assigns a unique rank to each line, leaving gaps in case of ties.
* **DENSE_RANK()**: Assigns a unique rank to each line, with continuous ranks for tied lines.
* **ROW_NUMBER()**: Assigns a unique sequential integer to each row, regardless of ties, without gaps.

### Example: Classification of the most sold products BY order ID

ex: the same product can come first because it sold a lot per ORDER and then come second because it sold a lot per ORDER

```sql
SELECT  
  o.order_id, 
  p.product_name, 
  (o.unit_price * o.quantity) AS total_sale,
  ROW_NUMBER() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_rn, 
  RANK() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_rank, 
  DENSE_RANK() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_dense
FROM  
  order_details o
JOIN 
  products p ON p.product_id = o.product_id;
```

### Query Explanation

* **Data Selection**: The query selects the `order_id`, `product_name` from the `products` table, and calculates `total_sale` as the product of `unit_price` and `quantity` from the `order_details` table.
    
* **Classification Functions**:
    
    * **`ROW_NUMBER()`**: Assigns a sequential number to each row based on total sales (`total_sale`), ordered from highest to lowest. Each row is assigned a unique number within the entire result set.
    * **`RANK()`**: Assigns a rank to each line based on `total_sale`, where lines with equal values ​​receive the same rank, and the next available rank takes into account ties (for example, if two items share the first place, the next item will be third).
    * **`DENSE_RANK()`**: Works similarly to `RANK()`, but subsequent ranks have no gaps. If two items are tied for first place, the next item will be second.
    * **`JOIN`**: The join between `order_details` and `products` is done by `product_id`, allowing the product name to be included in the results based on the corresponding IDs in both tables.
    
## This report presents the ID of each order along with the total sales and the percentage ranking and cumulative distribution of the value of each sale in relation to the total sales value for the same order. These calculations are made based on the unit price and the quantity of products sold in each order.

### Example: Classification of the most sold products used SUB QUERY

```sql
SELECT  
  sales.product_name, 
  total_sale,
  ROW_NUMBER() OVER (ORDER BY total_sale DESC) AS order_rn, 
  RANK() OVER (ORDER BY total_sale DESC) AS order_rank, 
  DENSE_RANK() OVER (ORDER BY total_sale DESC) AS order_dense
FROM (
  SELECT 
    p.product_name, 
    SUM(o.unit_price * o.quantity) AS total_sale
  FROM  
    order_details o
  JOIN 
    products p ON p.product_id = o.product_id
  GROUP BY p.product_name
) AS sales
ORDER BY sales.product_name;
```

### Utility of the Query

This query is useful for sales analysis, where it is necessary to identify the best-selling products, as well as their ranking in terms of revenue generated. It allows analysts to quickly see which products generate the most revenue and how they rank relative to each other, facilitating strategic decisions related to inventory, promotions and sales planning.

### PERCENT_RANK() and CUME_DIST() functions

Both return a value between 0 and 1

* **PERCENT_RANK()**: Calculates the relative rank of a specific row within the result set as a percentage. It is computed using the following formula:
    * RANK is the rank of the row within the result set.
    *N is the total number of rows in the result set.
    * PERCENT_RANK = (RANK - 1) / (N - 1)
* **CUME_DIST()**: Calculates the cumulative distribution of a value in the result set. Represents the proportion of rows that are less than or equal to the current row. The formula is as follows:
    * CUME_DIST = (Number of rows with values ​​<= current row) / (Total number of rows)

Both the PERCENT_RANK() and CUME_DIST() functions are valuable for understanding the distribution and position of data points within a data set, particularly in scenarios where you want to compare the position of a specific value to the overall data distribution.

```sql
SELECT  
  order_id, 
  unit_price * quantity AS total_sale,
  ROUND(CAST(PERCENT_RANK() OVER (PARTITION BY order_id 
    ORDER BY (unit_price * quantity) DESC) AS numeric), 2) AS order_percent_rank,
  ROUND(CAST(CUME_DIST() OVER (PARTITION BY order_id 
    ORDER BY (unit_price * quantity) DESC) AS numeric), 2) AS order_cume_dist
FROM  
  order_details;
```

### Explanation of the Adjusted Query:

* **Data Selection**: The query selects the `order_id` and calculates `total_sale` as the product of `unit_price` and `quantity`.
* **Window Functions**:
* **`PERCENT_RANK()`**: Applied with a partition by `order_id` and ordered by `total_sale` in descending order, it calculates the percentage position of each sale in relation to all others in the same order.
* **`CUME_DIST()`**: Similarly, calculates the cumulative distribution of sales, indicating the proportion of sales that do not exceed the `total_sale` of the current line within each order.
* **Rounding**: The results of `PERCENT_RANK()` and `CUME_DIST()` are rounded to two decimal places for easier interpretation.

This query is useful for detailed analysis of sales performance within orders, allowing managers and analysts to quickly identify which items contribute the most

The NTILE() function in SQL is used to divide the result set into a specified number of approximately equal parts or "bands" and assign a group or "bucket" number to each row based on its position within the result set ordered.

```sql
NTILE(n) OVER (ORDER BY column)
```

* **n**: The number of tracks or groups you want to create.
* **ORDER BY column**: The column by which you want to order the result set before applying the NTILE() function.

### Example: List employees by dividing them into 3 groups

```sql
SELECT first_name, last_name, title,
   NTILE(3) OVER (ORDER BY first_name) AS group_number
FROM employees;
```

### Explanation of the Adjusted Query:

* **Data Selection**: The query selects `first_name`, `last_name` and `title` from the `employees` table.
* **NTILE(3) OVER (ORDER BY first_name)**: Applies the NTILE function to divide employees into 3 groups based on the alphabetical order of their first names. Each employee will be assigned a group number (`group_number`) that indicates which of the three groups they belong to.

This query is useful for analyzes that require the equitable distribution of data into specified groups, such as for workload balancing, segmented analyses, or even for reporting purposes where dividing into groups makes data easier to visualize and understand.

LAG(), LEAD()

* **LAG()**: Allows you to access the value of the previous line within a result set. This is particularly useful for making comparisons with the current line or identifying trends over time.
* **LEAD()**: Allows you to access the value of the next line within a set of results, enabling comparisons with the subsequent line.

### Example: Sorting the shipping costs paid by customers according to their order dates:

```sql
SELECT 
  customer_id, 
  TO_CHAR(order_date, 'YYYY-MM-DD') AS order_date, 
  shippers.company_name AS shipper_name, 
  LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS previous_order_freight, 
  freight AS order_freight, 
  LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS next_order_freight
FROM 
  orders
JOIN 
  shippers ON shippers.shipper_id = orders.ship_via;
```

* **LEAD() and LAG(): These window functions are used to access data from previous or subsequent lines within a defined partition, very useful for comparing the shipping value between consecutive orders from the same customer.