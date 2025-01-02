# Class 02 - SQL for Analytics: Our first queries

## Objective

Carry out our first consultations at Northwind bank

## A tangent before we carry out our first consultations

SQL, or Structured Query Language, is a programming language designed to manage data stored in a relational database management system (RDBMS). SQL has several components, each responsible for different types of tasks and operations that can be performed on a database. These components include DDL, DML, DCL, and DQL, among others. Here is a summary of each of them:

Each component of the SQL language plays a fundamental role in the management and use of databases, and different types of technology professionals can use these commands to perform their specific functions. Let's detail who is generally responsible for each type of command and what the purpose of each of the components mentioned is (DDL, DML, DQL, DCL, TCL):

### 1. DDL (Data Definition Language)

DDL or Data Definition Language is used to define and modify the structure of the database and its objects, such as tables, indexes, restrictions, schemas, among others. DDL commands include:

* **CREATE**: Used to create new objects in the database, such as tables, indexes, functions, views, triggers, etc.
* **ALTER**: Modifies the structure of an existing object in the database, for example, adding a column to a table or changing characteristics of an existing column.
* **DROP**: Removes objects from the database.
* **TRUNCATE**: Removes all records from a table, freeing the space occupied by these records.

* **Responsible**: Database administrators (DBAs) and database developers.
* **Purpose**: DDL is used to create and modify the structure of the database and its objects. These commands help define how data is organized, stored, and how relationships between them are established. They are essential during the database design phase and when changes to the structure are required.

### 2. DML (Data Manipulation Language)

DML or Data Manipulation Language is used to manage data within objects (like tables). Includes commands to insert, modify and delete data:

* **INSERT**: Inserts data into a table.
* **UPDATE**: Changes existing data in a table.
* **DELETE**: Removes data from a table.
* **MERGE**: An operation that allows you to insert, update or delete records in a table based on a set of determined conditions.

* **Responsible**: Software developers, data analysts, and occasionally end users through interfaces that execute DML commands behind the scenes.
* **Purpose**: DML is crucial for managing data within tables. It is used to insert, update, delete and manipulate stored data. Data analysts can use DML to prepare datasets for analysis, while developers use it to implement business logic.

### 3. DQL (Data Query Language)

DQL or Data Query Language is fundamentally used to perform queries on data. The best-known command in DQL is **SELECT**, which is used to retrieve data from one or more tables.

* **Responsible**: Data analysts, data scientists, and any user who needs to extract information from the database.
* **Purpose**: DQL is used to query and retrieve data. It is essential for generating reports, carrying out analysis, and providing data that helps in decision making. The `SELECT` command, part of DQL, is one of the most used and is essential for any task that requires data visualization or analysis.

### 4. DCL (Data Control Language)

The DCL or Data Control Language includes commands related to security in the accessibility of data in the database. This involves commands to grant and revoke access permissions:

* **GRANT**: Grants access permissions to users.
* **REVOKE**: Removes access permissions.

* **Responsible**: Database administrators.
* **Purpose**: DCL is used to configure permissions on a database, ensuring that only authorized users can access, modify, or manage data. This is crucial for data security and governance, protecting sensitive information and maintaining system integrity.

### 5. TCL (Transaction Control Language)

TCL or Transaction Control Language is used to manage transactions in the database. Transactions are important to maintain data integrity and ensure that multiple operations complete successfully or not at all:

* **COMMIT**: Commits a transaction, making all changes permanent in the database.
* **ROLLBACK**: Undoes all changes made during the current transaction.
* **SAVEPOINT**: Defines a point in the transaction that can be used for a partial rollback.

* **Responsible**: Software developers and database administrators.
* **Purpose**: TCL is used to manage database transactions, ensuring that operations are completed successfully or rolled back in case of error. This is essential to maintain data consistency and integrity, especially in environments where multiple transactions occur simultaneously.

This separation of responsibilities helps maintain the organization and efficiency of database operations, as well as ensuring that actions performed in a database environment are secure and aligned with the organization's needs.

## If we look at the commands we made yesterday...

1) This command is from which subset?

```sql
SELECT * FROM customers WHERE country='Mexico';
```

2) This command is from which subset?

```sql
INSERT INTO customers VALUES ('ALFKI', 'Alfreds Futterkiste', 'Maria Anders', 'Sales Representative', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany', '030-0074321' , '030-0076545');
INSERT INTO customers VALUES ('ANATR', 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Owner', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico', '(5) 555-4729', '(5) 555-3745');
INSERT INTO customers VALUES ('ANTON', 'Antonio Moreno Taquería', 'Antonio Moreno', 'Owner', 'Mataderos 2312', 'México D.F.', NULL, '05023', 'Mexico', '(5) 555- 3932', NULL);
INSERT INTO customers VALUES ('AROUT', 'Around the Horn', 'Thomas Hardy', 'Sales Representative', '120 Hanover Sq.', 'London', NULL, 'WA1 1DP', 'UK', '(171 ) 555-7788', '(171) 555-6750');
INSERT INTO customers VALUES ('BERGS', 'Berglunds snabbköp', 'Christina Berglund', 'Order Administrator', 'Berguvsvägen 8', 'Luleå', NULL, 'S-958 22', 'Sweden', '0921-12 34 65', '0921-12 34 67');
```

3) This command is from which subset?

```sql
CREATE TABLE suppliers (
    supplier_id smallint NOT NULL,
    company_name character varying(40) NOT NULL,
    contact_name character varying(30),
    contact_title character varying(30),
    address character varying(60),
    city ​​character varying(15),
    region character varying(15),
    postal_code character varying(10),
    country character varying(15),
    phone character varying(24),
    fax character varying(24),
    home page text
);
```

4) This command is from which subset?

```sql
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
```

## Now let's go to our first QUERY? (Data Query Language)

Data Query Language (DQL) is a subset of SQL (Structured Query Language) used specifically to query data in databases. DQL is essential for extracting information, performing analysis and generating reports from data stored in a relational database management system (RDBMS). The main command in DQL is `SELECT`, which is widely used to select data from one or more tables.

**DQL Objectives**

The main objective of DQL is to allow users and applications to efficiently and accurately retrieve data from a database. DQL provides the flexibility to specify exactly what data is needed, how it should be filtered, grouped, sorted and transformed. This makes DQL an essential tool for:

* **Data analysis**: Extract data sets for analysis and evidence-based decision making.
* **Reporting**: Create detailed reports that help organizations understand operational and strategic performance.
* **Data visualization**: Powering visualization tools with data that helps represent complex information in an understandable way.
* **Audit and monitoring**: Track and review operations and transactions for compliance and security.

**How ​​to get started with DQL**

To get started using DQL, it is essential to have a basic knowledge of SQL and understand the structure of the data within the database you are working with. Here are some steps to get started:

1. **Understand the database schema**: Know the tables, columns, data types and relationships between tables.
2. **Learn the basics of the `SELECT` command**: Start with simple queries to select specific columns from a table.
3. **Use clauses to refine your queries**:
    * **WHERE**: To filter records.
    * **GROUP BY**: To group records.
    * **HAVING**: To filter groups.
    * **ORDER BY**: To order the results.
4. **Practice with example data**: Use an example database to practice your queries and test different scenarios.

**Main DQL commands**

* **SELECT**: The most fundamental command in DQL, used to select data from one or more tables.
    
    ```sql
    SELECT * FROM customers;
    select contact_name, city from customers;
    ```
    
* **DISTINCT**: Used with `SELECT` to return only distinct values.
    
    ```sql
    select country from customers;
    select distinct country from customers;
    select count(distinct country) from customers;
    ```

* **WHERE**: Used to filter.

```sql
-- Selects all customers from Mexico
SELECT * FROM customers WHERE country='Mexico';
-- Select customers with specific ID
SELECT * FROM customers WHERE customer_id='ANATR';
-- Use AND for multiple criteria
SELECT * FROM customers WHERE country='Germany' AND city='Berlin';
-- Use OR for more than one city
SELECT * FROM customers WHERE city='Berlin' OR city='Aachen';
-- Use NOT to exclude Germany
SELECT * FROM customers WHERE country<>'Germany';
-- Combines AND, OR and NOT
SELECT * FROM customers WHERE country='Germany' AND (city='Berlin' OR city='Aachen');
-- Excludes customers from Germany and USA
SELECT * FROM customers WHERE country<>'Germany' AND country<>'USA';
```

### More operators

Comparison operators in SQL are essential for filtering records in queries based on specific conditions. Let's look at each of the operators you mentioned (`<`, `>`, `<=`, `>=`, `<>`) with practical examples. Suppose we have a table called `products` with a `unit_price` column for the price of the products and a `units_in_stock` column for the number of items in stock.

### Operator `<` (Less than)

```sql
-- Selects all products with a price less than 20
SELECT * FROM products
WHERE unit_price < 20;
```

### Operator `>` (Greater than)

```sql
-- Selects all products with a price greater than 100
SELECT * FROM products
WHERE unit_price > 100;
```

### Operator `<=` (Less than or equal to)

```sql
-- Selects all products with a price less than or equal to 50
SELECT * FROM products
WHERE unit_price <= 50;
```

### Operator `>=` (Greater than or equal to)

```sql
-- Selects all products with a stock quantity greater than or equal to 10
SELECT * FROM products
WHERE units_in_stock >= 10;
```

### Operator `<>` (Not equal to)

```sql
-- Selects all products whose price is not 30
SELECT * FROM products
WHERE unit_price <> 30;
```

### Combination of Operators

You can also combine multiple operators in a single query to create more specific conditions:

```sql
-- Selects all products priced between 50 and 100 (exclusive)
SELECT * FROM products
WHERE unit_price >= 50 AND unit_price < 100;
```

```sql
-- Selects all products with a price outside the range 20 to 40
SELECT * FROM products
WHERE unit_price < 20 OR unit_price > 40;
```

* **Is null and is not null**: Used in conjunction with `where` to create more complex filter rules on records.

```sql
SELECT * FROM customers
WHERE contact_name is Null;

SELECT * FROM customers
WHERE contact_name is not null;
```

* **LIKE**

```SQL
-- Customer name starting with "a":
SELECT * FROM customers
WHERE contact_name LIKE 'a%';
```

To treat strings as uppercase or lowercase in an SQL query, you can use the `UPPER()` or `LOWER()` functions, respectively. These functions convert all letters in a string to uppercase or lowercase, allowing you to make comparisons more flexibly, ignoring case differences.

Here is how you can modify the query to find all customers whose name starts with the letter "a", regardless of whether it is uppercase or lowercase:

### To find names that start with upper or lower case "a":

```sql
SELECT * FROM customers
WHERE LOWER(contact_name) LIKE 'a%';
```

This query converts the entire `contact_name` to lowercase before doing the comparison, which makes the search case insensitive.

### To find names that start with a capital "A":

```sql
SELECT * FROM customers
WHERE UPPER(contact_name) LIKE 'A%';
```

This query converts the entire `contact_name` to uppercase before doing the comparison, ensuring that only names starting with a capital "A" are selected.

Using `UPPER()` or `LOWER()` is a common practice to ensure that conditions applied to text fields are not affected by differences in capitalization in data inputs.

```sql
-- Customer name ending with "a":
SELECT * FROM customers
WHERE contact_name LIKE '%a';

-- Customer name that has "or" in any position:
SELECT * FROM customers
WHERE contact_name LIKE '%or%';

-- Customer name with "r" in the second position:
SELECT * FROM customers
WHERE contact_name LIKE '_r%';

-- Customer name that starts with "A" and is at least 3 characters long:
SELECT * FROM customers
WHERE contact_name LIKE 'A_%_%';

-- Contact name that starts with "A" and ends with "o":
SELECT * FROM customers
WHERE contact_name LIKE 'A%o';

-- Customer name that does NOT start with "a":
SELECT * FROM customers
WHERE contact_name NOT LIKE 'A%';

-- Using the [charlist] wildcard (SQL server)
SELECT * FROM customers
WHERE city LIKE '[BSP]%';

-- Using the Similar To wildcard (Postgres)
SELECT * FROM customers
WHERE city SIMILAR TO '(B|S|P)%';

-- Using MySQL (poor thing, there's nothing)
SELECT * FROM customers
WHERE (city LIKE 'B%' OR city LIKE 'S%' OR city LIKE 'P%');
```

* **IN Operator**

```sql
-- located in "Germany", "France" or "United Kingdom":
SELECT * FROM customers
WHERE country IN ('Germany', 'France', 'UK');

-- NOT located in "Germany", "France" or "United Kingdom":
SELECT * FROM customers
WHERE country NOT IN ('Germany', 'France', 'UK');

-- Just to give you a taste of a subqueyr... Selects all customers who are from the same countries as the suppliers:

SELECT * FROM customers
WHERE country IN (SELECT country FROM suppliers);

-- Example with BETWEEN
SELECT * FROM products
WHERE unit_price BETWEEN 10 AND 20;

-- Example with NOT BETWEEN
SELECT * FROM products
WHERE unit_price NOT BETWEEN 10 AND 20;

-- Selects all products with a price BETWEEN 10 and 20. Additionally, it does not show products with a CategoryID of 1, 2 or 3:
SELECT * FROM products
WHERE (unit_price BETWEEN 10 AND 20) AND category_id NOT IN (1, 2, 3);
```

```sql
--selects all products between 'Carnarvon Tigers' and 'Mozzarella di Giovanni':
select * from products
where product_name between 'Carnarvon Tigers' and 'Mozzarella di Giovanni'
order by product_name;

--Select all BETWEEN orders '04-July-1996' and '09-July-1996':
select * from orders
where order_date between '07/04/1996' and '07/09/1996';
```

* **Tangent about different banks**

The SQL command you mentioned is specific to PostgreSQL and not necessarily standard across all DBMSs (Database Management Systems). Each DBMS may have slightly different functions and date formats. However, the basic structure of the `SELECT` command and the `WHERE` clause using `BETWEEN` are quite universal.

Here are some variants for other popular DBMSs:

### SQL Server

To format dates in SQL Server, you would use the `CONVERT` or `FORMAT` function (as of SQL Server 2012):

```sql
-- Using CONVERT
SELECT CONVERT(VARCHAR, order_date, 120) FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- Using FORMAT
SELECT FORMAT(order_date, 'yyyy-MM-dd') FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';
```

### MySQL

MySQL uses the `DATE_FORMAT` function to format dates:

```sql
SELECT DATE_FORMAT(order_date, '%Y-%m-%d') FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';
```

###Oracle

Oracle also uses the `TO_CHAR` function like PostgreSQL for date formatting:

```sql
SELECT TO_CHAR(order_date, 'YYYY-MM-DD') FROM orders
WHERE order_date BETWEEN TO_DATE('1996-04-07', 'YYYY-MM-DD') AND TO_DATE('1996-09-07', 'YYYY-MM-DD');
```

### SQLite

SQLite doesn't have a dedicated function for formatting dates, but you can use string functions to manipulate standard date formats:

```sql
SELECT strftime('%Y-%m-%d', order_date) FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';
```

* **Aggregate Functions** (COUNT, MAX, MIN, SUM, AVG): Used to perform calculations on a set of values.

Aggregate functions are a fundamental tool in the SQL language, used to perform calculations on a set of values ​​and return a single resulting value. These functions are especially useful in operations that involve statistical analysis of data, such as obtaining averages, sums, maximum and minimum values, among others. When operating on datasets, aggregate functions allow you to extract meaningful insights, support business decisions, and simplify complex data into manageable information.
    
Aggregate functions are often used in SQL queries with the GROUP BY clause, which groups rows that have the same values ​​in specified columns. However, they can be used without GROUP BY to summarize all data in a table. Here are the main aggregate functions and how they are applied:

```sql
-- MIN() example
SELECT MIN(unit_price) AS minimum_price
FROM products;

-- MAX() example
SELECT MAX(unit_price) AS maximum_price
FROM products;

-- COUNT() example
SELECT COUNT(*) AS total_of_products
FROM products;

-- AVG() example
SELECT AVG(unit_price) AS preco_medio
FROM products;

-- SUM() example
SELECT SUM(quantity) AS total_quantity_of_order_details
FROM order_details;
```

### Best Practices

* **Data precision**: When using `AVG()` and `SUM()`, be aware of the column data type to avoid inaccuracies, especially with float data.
* **NULLs**: Remember that most aggregate functions ignore `NULL` values, except `COUNT(*)`, which counts all rows, including those with `NULL` values.
* **Performance**: In very large tables, aggregate operations can be costly in terms of performance. Consider using appropriate indexes or performing pre-aggregations where applicable.
* **Clarity**: When using `GROUP BY`, ensure that all non-aggregated columns in your `SELECT` clause are included in the `GROUP BY` clause.

### Example of MIN() with GROUP BY

```sql
-- Calculates the lowest unit price of products in each category
SELECT category_id, MIN(unit_price) AS minimum_price
FROM products
GROUP BY category_id;
```

### Example of MAX() with GROUP BY

```sql
-- Calculates the highest unit price of products in each category
SELECT category_id, MAX(unit_price) AS preco_maximo
FROM products
GROUP BY category_id;
```

### Example of COUNT() with GROUP BY

```sql
-- Counts the total number of products in each category
SELECT category_id, COUNT(*) AS total_de_produtos
FROM products
GROUP BY category_id;
```

### Example of AVG() with GROUP BY

```sql
-- Calculates the average unit price of products in each category
SELECT category_id, AVG(unit_price) AS preco_medio
FROM products
GROUP BY category_id;
```

### Example of SUM() with GROUP BY

```sql
-- Calculates the total quantity of products ordered per order
SELECT order_id, SUM(quantity) AS total_quantity_per_order
FROM order_details
GROUP BY order_id;
```

* **Challenge**

1. Get all columns from the Customers, Orders and Suppliers tables

```sql
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM suppliers;
```

2. Get all Customers in alphabetical order by country and name

```sql
SELECT *
FROM customers
ORDER BY country, contact_name;
```

3. Get the 5 oldest orders

```sql
SELECT * 
FROM orders 
ORDER BY order_date
LIMIT 5;
```

4. Get the count of all Orders placed during 1997

```sql
SELECT COUNT(*) AS "Number of Orders During 1997"
FROM orders
WHERE order_date BETWEEN '1997-1-1' AND '1997-12-31';
```

5. Get the names of all contact persons where the person is a manager, in alphabetical order

```sql
SELECT contact_name
FROM customers
WHERE contact_title LIKE '%Manager%'
ORDER BY contact_name;
```

6. Get all orders placed on May 19, 1997

```sql
SELECT *
FROM orders
WHERE order_date = '1997-05-19';
```