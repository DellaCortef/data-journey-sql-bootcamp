# Class 01 - Overview and Preparation of the SQL environment

## Introduction

Welcome to our SQL and PostgreSQL workshop. Today, we'll dive into the basics of databases and how PostgreSQL can be used to manage data efficiently. Our goal is to ensure that you all have a good foundation to explore more about SQL and database operations in the coming days.

## Why Postgres?

PostgreSQL is a relational database management system (RDBMS) developed in the Department of Computer Science at the University of California at Berkeley. POSTGRES pioneered many concepts that only became available in some commercial database systems much later:

* complex queries
* foreign keys
* triggers
* updatable views
* transactional integrity

Furthermore, PostgreSQL can be extended by the user in various ways, for example by adding new

* data types
*functions
*operators
* aggregate functions
*indexmethods
*procedural languages

## Additional Information 

In addition to the course content, I recommend some other places to study.

[Documentation](https://www.postgresql.org/docs/current/index.html) Official Postgres documentation, all features are here.


[Wiki](https://wiki.postgresql.org/wiki/Main_Page) The PostgreSQL wiki contains the Frequently Asked Questions (FAQ), to-do list (TODO), and detailed information on many other topics.

[Site](https://www.postgresql.org/) on the Web The PostgreSQL website provides details about the latest version and other information to make your work or play with PostgreSQL more productive.

[Community](https://github.com/postgres/postgres) The code PostgreSQL is an open source project. As such, it relies on the user community for ongoing support. As you begin using PostgreSQL, you will depend on others for help, whether through the documentation or mailing lists. Consider giving back your knowledge. Read the mailing lists and answer the questions. If you learn something that isn't in the documentation, write it down and contribute it. If you add features to the code, please contribute them.

## Setup

Before you can use PostgreSQL, you need to install it, of course. It's possible that PostgreSQL is already installed at your location, either because it was included in your operating system distribution or because your system administrator has already installed it.

If you are not sure if PostgreSQL is already available or if you can use it for your experiments, then you can install it yourself. Doing this is not difficult and can be good exercise.

- Installing Postgres Local

## Fundamentals of Architecture

Before we proceed, it is important that you understand the basic architecture of the PostgreSQL system. Understanding how the parts of PostgreSQL interact will make everything easier.

In technology jargon, PostgreSQL uses a client/server model.

A server process, which manages the database files, accepts database connections from client applications, and performs actions on the database on behalf of clients. The database server program is called postgres.

The user's client application (frontend) that wants to perform database operations. Client applications can be very diverse in nature: a client can be a text-oriented tool, a graphical application, a web server that accesses the database to display web pages, or a specialized database maintenance tool. Some client applications ship with the PostgreSQL distribution; most are developed by users.

As is typical in client/server applications, the client and server can be on different hosts. In this case, they communicate over a TCP/IP network connection. You should keep this in mind because files that can be accessed on a client machine may not be accessible (or may only be accessible with a different file name) on the database server machine.

PostgreSQL server can handle multiple simultaneous client connections. To achieve this, it starts (“forks”) a new process for each connection. From that point on, the client and the new server process communicate without intervention from the original postgres process. Thus, the supervisor server process is always running, waiting for client connections, while associated client and server processes come and go. (All of this, of course, is invisible to the user. We only mention it here for completeness.)

## Creating a Database

The first test to see if you can access the database server is to try to create a database. A running PostgreSQL server can manage multiple databases. Typically, a separate database is used for each project or user.

To do this, we will enter our client `pgAdmin 4`

We can also connect to remote servers, e.g. `Render`

## Creating our Schema

![Northwind database](https://github.com/pthom/northwind_psql/raw/master/ER.png)

For this project, we will use a simple SQL script that will populate a database with the famous [Northwind](https://github.com/pthom/northwind_psql) example, adapted for PostgreSQL. This script will set up the Northwind database in PostgreSQL, creating all the necessary tables and inserting sample data so that you can immediately start working with SQL queries and analysis in a practical context. This example database is a great tool for learning and practicing SQL operations and techniques, especially useful for understanding how to manipulate relational data in a realistic environment.

## First commands

Let's now move on to an introductory guide to basic SQL operations using the Northwind database. Each SQL command will be explained with a brief introduction to help with understanding and practical application.

#### Complete Selection Example

To select all data from a table:

```sql
-- Displays all records from the Customers table
SELECT * FROM customers;
```

#### Selection of Specific Columns

To select specific columns:

```sql
-- Displays customers' contact name and city
SELECT contact_name, city FROM customers;
```

#### Using DISTINCT

To select distinct values:

```sql
-- List all customer countries
SELECT country FROM customers;
-- List countries without repetition
SELECT DISTINCT country FROM customers;
-- Counts how many unique countries there are
SELECT COUNT(DISTINCT country) FROM customers;
```

#### WHERE clause

To filter records:

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

#### ORDER BY

To sort the results:

```sql
-- Sorts customers by country
SELECT * FROM customers ORDER BY country;
-- Sort by country in descending order
SELECT * FROM customers ORDER BY country DESC;
-- Sort by country and contact name
SELECT * FROM customers ORDER BY country, contact_name;
-- Sort by country in ascending order and name in descending order
SELECT * FROM customers ORDER BY country ASC, contact_name DESC;
```

#### Using LIKE and IN
To search for patterns and lists of values:

```sql
-- Customers with contact name starting with "a"
SELECT * FROM customers WHERE contact_name LIKE 'a%';
-- Customers with contact name not starting with "a"
SELECT * FROM customers WHERE contact_name NOT LIKE 'a%';
--Customers from specific countries
SELECT * FROM customers WHERE country IN ('Germany', 'France', 'UK');
-- Customers not located in 'Germany', 'France', 'UK'
SELECT * FROM customers WHERE country NOT IN ('Germany', 'France', 'UK');
```

#### Challenge

- Install Postgres
- Create local Northwind project
- Carry out all the commands above