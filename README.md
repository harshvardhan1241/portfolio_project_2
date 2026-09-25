# 📚 Library Database Management System

A small **Library Database Management System** built using **PostgreSQL** to practice SQL and database management concepts through a real-world library use case.

The project manages books, members, employees, library branches, book issues, and book returns. It also includes SQL analysis, reporting, CTAS queries, and stored procedures.

---

## 📌 Project Overview

The database is designed to manage the basic operations of a library, including:

* Managing books
* Managing library members
* Managing employees and branches
* Issuing books
* Returning books
* Tracking book availability
* Identifying overdue books
* Calculating fines
* Analyzing branch and employee performance
* Tracking damaged books

---

## 🗄️ Database Tables

The project contains the following tables:

| Table           | Purpose                              |
| --------------- | ------------------------------------ |
| `branch`        | Stores library branch details        |
| `employees`     | Stores employee information          |
| `books`         | Stores book details and availability |
| `members`       | Stores library member details        |
| `issued_status` | Stores book issue records            |
| `return_status` | Stores book return records           |

### Database Relationship

```text
branch
   │
   └── employees
          │
          └── issued_status
                 │
        ┌────────┼─────────┐
        ↓        ↓         ↓
     members   books   return_status
```

Foreign keys are used to connect the tables and maintain referential integrity.

---

## 🔑 Database Constraints

The project uses:

* Primary Keys
* Foreign Keys
* `NOT NULL` concepts where required
* Default values
* Referential integrity

Example relationships:

```text
employees.branch_id
        ↓
branch.branch_id

issued_status.issued_member_id
        ↓
members.member_id

issued_status.issued_book_isbn
        ↓
books.isbn

issued_status.issued_emp_id
        ↓
employees.emp_id

return_status.issued_id
        ↓
issued_status.issued_id
```

---

## 📖 SQL Concepts Covered

### Basic SQL

* `CREATE DATABASE`
* `CREATE TABLE`
* `DROP TABLE`
* `ALTER TABLE`
* `SELECT`
* `INSERT`
* `UPDATE`
* `DELETE`

### Filtering & Sorting

* `WHERE`
* `ORDER BY`
* `IS NULL`

### Aggregation

* `COUNT()`
* `SUM()`
* `GROUP BY`
* `HAVING`

### Joins

* `INNER JOIN`
* `LEFT JOIN`
* Multiple table joins

### Advanced SQL

* Subqueries
* CTAS (`CREATE TABLE AS`)
* Date calculations
* `CURRENT_DATE`
* `INTERVAL`
* Foreign key constraints
* NULL handling

### PL/pgSQL

* Stored Procedures
* Variables
* `IF / ELSE`
* `RAISE NOTICE`

---

# 📝 Tasks Completed

## Basic SQL Operations

### Task 1 — Create a New Book Record

Added a new book to the `books` table using `INSERT`.

### Task 2 — Update Member Address

Updated an existing member's address using `UPDATE`.

### Task 3 — Delete an Issued Book Record

Attempted to delete an issued book record and handled the foreign-key dependency with `return_status`.

### Task 4 — Retrieve Books Issued by an Employee

Retrieved books processed by a specific employee using filtering and sorting.

### Task 5 — Members Who Issued More Than One Book

Used:

```sql
GROUP BY
HAVING COUNT(*) > 1
```

to identify members who issued multiple books.

---

## 📊 CTAS & Data Analysis

### Task 6 — Book Issue Summary

Created a summary table using CTAS to calculate the total number of times each book was issued.

```sql
CREATE TABLE book_count AS
SELECT ...
```

### Task 7 — Books by Category

Used `GROUP BY` and `COUNT()` to analyze the number of books in each category.

### Task 8 — Rental Income by Category

Used `SUM()` and `COUNT()` to analyze rental information by category.

### Task 9 — Recently Registered Members

Used PostgreSQL date operations to find members registered within the last 180 days.

```sql
CURRENT_DATE - INTERVAL '180 days'
```

### Task 10 — Employee and Branch Information

Used multiple joins to display employees together with their branch and branch manager information.

### Task 11 — Books Above Rental Price

Created a table containing books whose rental price is above a specified threshold.

### Task 12 — Books Not Yet Returned

Used `LEFT JOIN` and `IS NULL` to identify books that have been issued but do not have a return record.

```sql
WHERE rst.return_id IS NULL
```

---

# 🚀 Advanced SQL Operations

### Task 13 — Identify Overdue Books

Identified books that:

* Have not been returned
* Were issued more than 30 days ago

The query calculates the number of overdue days using:

```sql
CURRENT_DATE - issued_date
```

### Task 14 — Update Book Status on Return

Created a stored procedure that inserts a return record and changes the book status to available.

### Task 15 — Branch Performance Report

Created a branch report containing:

* Number of books issued
* Number of books returned
* Total rental revenue

### Task 16 — Active Members

Used CTAS to create an `active_members` table containing members who issued books within the previous six months.

### Task 17 — Employee Performance

Analyzed employees based on the number of book issues they processed.

### Task 18 — Damaged Book Analysis

Added `book_quality` to `return_status` and identified members associated with multiple damaged-book returns.

---

# ⚙️ Stored Procedures

## Issue Book Procedure

The `issue_book` procedure checks whether a book is available before issuing it.

### Logic

```text
Check Book Status
       ↓
Is Book Available?
    ↙       ↘
  YES        NO
   ↓          ↓
Issue Book   Show Notice
   ↓
Change Status
to "no"
```

The procedure:

1. Checks the book status.
2. Issues the book if it is available.
3. Inserts the issue record.
4. Changes the book status to `no`.
5. Displays a notice if the book is unavailable.

---

## Return Book Procedure

The `add_return_record` procedure handles book returns.

### Logic

```text
Return Book
     ↓
Insert Return Record
     ↓
Find Book ISBN
     ↓
Update Books Table
     ↓
Set Status = "yes"
```

The procedure also uses PL/pgSQL variables to retrieve the ISBN and book name associated with the issued book.

---

# 💰 Overdue Fine Calculation

The project calculates overdue fines at:

```text
$0.50 per overdue day
```

The final CTAS query generates a table containing:

| Column        | Description             |
| ------------- | ----------------------- |
| Member ID     | Library member          |
| Overdue Books | Number of overdue books |
| Total Fine    | Total calculated fine   |

The fine is calculated using:

```sql
SUM((CURRENT_DATE - issued_date) * 0.50)
```

---

# 🐛 Problems Faced & Solutions

## 1. Incorrect Column Size

Some columns were initially too small for the required data.

For example:

```sql
branch_address VARCHAR(10)
```

was changed to:

```sql
VARCHAR(40)
```

using `ALTER TABLE`.

---

## 2. Incorrect Data Type

The `salary` column initially used an unsuitable data type.

It was changed to:

```sql
FLOAT
```

using:

```sql
ALTER TABLE employees
ALTER salary TYPE FLOAT;
```

---

## 3. Foreign Key Delete Error

While deleting an issued record, PostgreSQL returned a foreign-key constraint error because the record was referenced by `return_status`.

### Problem

```text
issued_status
      ↑
      │
return_status
```

The dependent return record had to be removed before deleting the issue record.

This helped demonstrate how foreign-key dependencies work.

---

## 4. Invalid Foreign Key During Data Import

While importing CSV data, a `return_status` record referenced an `issued_id` that did not exist in `issued_status`.

This caused:

```text
violates foreign key constraint
```

The invalid record was removed from the CSV data and the data was imported again.

---

## 5. Finding Unreturned Books

The challenge was to identify issued books that did not have a corresponding return record.

The solution was:

```sql
LEFT JOIN return_status
ON issued_status.issued_id = return_status.issued_id
```

followed by:

```sql
WHERE return_status.return_id IS NULL
```

---

## 6. Filtering Aggregated Data

`WHERE` cannot be used to filter the result of an aggregate function such as `COUNT()` after grouping.

Instead, `HAVING` was used:

```sql
GROUP BY issued_member_id
HAVING COUNT(*) > 1;
```

This helped understand the difference between `WHERE` and `HAVING`.

---

## 7. Updating Book Status After Return

The return procedure receives an `issued_id`, while the `books` table needs the ISBN to update the correct book.

A PL/pgSQL variable was used to first retrieve the ISBN:

```sql
SELECT issued_book_isbn
INTO v_isbn
FROM issued_status
WHERE issued_id = p_issued_id;
```

Then the book status was updated:

```sql
UPDATE books
SET status = 'yes'
WHERE isbn = v_isbn;
```

---

# 🧠 Key Learnings

Through this project, I learned how different SQL concepts work together in a real database system.

The major concepts practiced were:

```text
Database Design
      ↓
Tables & Relationships
      ↓
Primary & Foreign Keys
      ↓
CRUD Operations
      ↓
Joins
      ↓
Aggregation
      ↓
CTAS
      ↓
Date Analysis
      ↓
Reporting
      ↓
PL/pgSQL Procedures
```

The project also helped me understand practical database problems such as foreign-key dependency errors, incorrect data types, invalid imported records, NULL handling, and updating related tables.

---

# 📂 Project Files

```text
Library-Database-Management-System/
│
├── README.md
│
├── database/
│   ├── create_database.sql
│   ├── create_tables.sql
│   └── constraints.sql
│
├── data/
│   └── library_data.csv
│
└── queries/
    ├── basic_operations.sql
    ├── data_analysis.sql
    ├── advanced_queries.sql
    └── stored_procedures.sql
```

---

# 🔮 Future Improvements

Some possible improvements for this project are:

* Add transactions for issue and return operations
* Add stronger validation inside stored procedures
* Automatically calculate return deadlines
* Automatically calculate overdue fines
* Add more detailed branch reports
* Add member and book search functionality
* Build a dashboard using the database
* Connect the database to a frontend application

---

# 👨‍💻 Author

**Harsh Dond**

This project was created as a practical PostgreSQL and SQL learning project covering beginner to advanced database concepts.
