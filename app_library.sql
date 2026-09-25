--creation of the database
CREATE DATABASE app_library;
                            --creation of the tabels--
--create tabel for branch
DROP TABLE if EXISTS branch ;
CREATE TABLE branch (
branch_id VARCHAR(10) primary key,
manager_id VARCHAR(10),
branch_address VARCHAR(10),
contact_no VARCHAR(10)
)

--late changes due to error 
-- error in the branch_address  var vlues is befre is 10 now we are making it 40

ALTER TABLE branch
ALTER branch_address type varchar(40)

--error in the  contact_no also var value is geting less and so ve arew making it 20

ALTER TABLE branch
ALTER contact_no type varchar(20)

--create tabel for employees
DROP TABLE if EXISTS employees;
CREATE table employees(
    emp_id varchar(10) PRIMARY KEY,
    emp_name varchar(25),
    position varchar(25),
    salary int,
    branch_id varchar(25) --FOREIGN KEY 
)

--late changes due to error 
-- error in the salary due to not proper data type

ALTER TABLE employees
ALTER salary type float

--create tabel for books
DROP TABLE if EXISTS books;
CREATE TABLE books(
isbn varchar(20) PRIMARY KEY,
book_title varchar(75),
category varchar(10),
rental_price float,
status varchar(15),
author varchar(35),
publisher varchar(55)
)
--late changes due to error 
-- error is the category var vlue is befre is 10 now we are making it 20
ALTER TABLE books
ALTER category type varchar(20)


--create tabel for members
DROP TABLE if EXISTS members;
CREATE TABLE members(
    member_id VARCHAR(10) PRIMARY KEY,
    member_name VARCHAR(25),
    member_address VARCHAR(75),
    reg_date DATE
)

--create tabel for issued_status
DROP TABLE if EXISTS issued_status;
CREATE TABLE issued_status(
issued_id VARCHAR(10) PRIMARY KEY,
issued_member_id VARCHAR(10) --FOREIGN KEY ,
issued_book_name VARCHAR(75),
issued_date DATE,
issued_book_isbn VARCHAR(20) --FOREIGN KEY ,
issued_emp_id VARCHAR(10) --FOREIGN KEY 
)

--create tabel for return_status
DROP TABLE if EXISTS return_status;
CREATE TABLE return_status(
    return_id VARCHAR(10) PRIMARY KEY,
    issued_id VARCHAR(10),--fk
    return_book_name VARCHAR(75),
    return_date DATE,
    return_book_isbn VARCHAR(20) --FOREIGN KEY 
)

--FOREIGN KEYs 
        --from issued_status_tabel to another
--for member 
ALTER TABLE issued_status
ADD CONSTRAINT  fk_members
FOREIGN KEY (issued_member_id)
REFERENCES  members (member_id)

--for book
ALTER TABLE issued_status
ADD CONSTRAINT  fk_books
FOREIGN KEY (issued_book_isbn)
REFERENCES  books (isbn)

-- for who from isusee the book
ALTER TABLE issued_status
ADD CONSTRAINT  fk_employees
FOREIGN KEY (issued_emp_id)
REFERENCES  employees (emp_id)

    -- from employees tabel to track the branch of book
-- for the track of the employ
ALTER TABLE employees
ADD CONSTRAINT  fk_branch
FOREIGN KEY ( branch_id)
REFERENCES  branch (branch_id)

    --from return_status tabel to issued tabel 
--to track the isshe things
ALTER TABLE return_status
ADD CONSTRAINT  fk_issued_status
FOREIGN KEY (issued_id)
REFERENCES  issued_status (issued_id)

/*ERROR: insert or update on table "return_status" violates foreign key constraint "fk_issued_status"
DETAIL: Key (issued_id)=(IS101) is not present in table "issued_status".
psql: error: utility failed with exit code: 1

so we delete that colum of innfo from csv file 
filnaly after 4 atempt we clear it all */

-- verifcation of data
SELECT*
FROM books

SELECT*
FROM branch

SELECT*
FROM employees

SELECT*
FROM issued_status

SELECT*
FROM members

SELECT*
FROM return_status
--all work



-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

-- Task 2: Update an Existing Member's Address


-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS109' from the issued_status table.

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E110'.


-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.


-- ### 3. CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt


-- ### 4. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:


-- Task 8: Find Total Rental Income by Category:


-- Task 9. **List Members Who Registered in the Last 180 Days**:

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold

-- Task 12: Retrieve the List of Books Not Yet Returned

    
/*
### Advanced SQL Operations

Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's name, book title, issue date, and days overdue.


Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to "available" when they are returned (based on entries in the return_status table).



Task 15: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.


Task 16: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 6 months.



Task 17: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.


Task 18: Identify Members Issuing High-Risk Books
Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. Display the member name, book title, and the number of times they've issued damaged books.    


Task 19: Stored Procedure
Objective: Create a stored procedure to manage the status of books in a library system.
    Description: Write a stored procedure that updates the status of a book based on its issuance or return. Specifically:
    If a book is issued, the status should change to 'no'.
    If a book is returned, the status should change to 'yes'.

Task 20: Create Table As Select (CTAS)
Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include:
    The number of overdue books.
    The total fines, with each day's fine calculated at $0.50.
    The number of books issued by each member.
    The resulting table should show:
    Member ID
    Number of overdue books
    Total fines
*/


-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books (isbn,book_title,category,rental_price,status,author,publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', '6.00', 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')

SELECT*FROM books

-- Task 2: Update an Existing Member's Address
UPDATE members
set 
member_address ='125 Main st'
WHERE member_id='C101'
SELECT* FROM members

-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS109' from the issued_status table.
SELECT* FROM issued_status

DELETE FROM issued_status
WHERE issued_id = 'IS109'
--SO THIS COMMAND WILL NEVER RUN BECAUSE THIS IS CONNECTED WITH FORIEN KEY SO WE ARE DOING SOMETHING DIFFERNT
--WE ARE DELETE FROM RETUN STAATUS FIST THEN WE WILL DELETE FROM ISSUED
--USING WITH CTE 
--we create the sub qurery in the main qurey named as deleted_return
WITH deleted_return as
(DELETE from return_status
WHERE issued_id='IS109')

DELETE FROM issued_status
WHERE issued_id = 'IS109'

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E110'.

/*here the we have all info in the single but if that is never given
we need to left joint to the fist employ id and issuedd employer id fist using of both tabel
then we are left joint issued_book_id to the isbn of book tabel and issued_status
then applied conditon */

SELECT*
FROM  issued_status 
WHERE issued_emp_id ='E110'
ORDER by issued_date desc

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.
/*

we used the count ffunction to get the value of the issued mamenger that is repated
then we are make colunm and gropu by them and we can not use the where function so we use having syntax */

SELECT
issued_member_id ,
count(*) as issue_Count
from issued_status
GROUP by issued_member_id
HAVING count(*) >'1'

-- ### 3. CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
--so we do the left joint alsp we use count function and group by for find no. of each 
--in group by we use for combine the row having the same values 
create TABLE  book_count AS
SELECT
b.isbn,
count(i_s.issued_id) as total_book_issue
from books as b
LEFT JOIN
issued_status as i_s
ON
b.isbn=i_s.issued_book_isbn
GROUP BY
b.isbn

SELECT *
FROM 
book_count


-- ### 4. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:
--i done the find the no. of book in each category
SELECT
category,
count(book_title)  as book_count
FROM
books
GROUP BY
category
--
SELECT*
from books
WHERE category='Classic'

-- Task 8: Find Total Rental Income by Category
select 
b.category,
sum(b.rental_price) as rental_income,
count(b.book_title)  as book_count
FROM
books as b
LEFT JOIN
issued_status as i_s
on i_s.issued_book_isbn =b.isbn
GROUP by 
b.category
/*fist i claocutale only the relat priice through book tabel
but the relat inscume is based on the how mauch that book has been given to rent
*/


-- Task 9. **List Members Who Registered in the Last 180 Days**:
SELECT*
FROM members
WHERE
reg_date >= CURRENT_DATE - interval '180 days'

INSERT into members (member_id,member_name,member_address,reg_date)
VALUES('C120','Deva Brown','133 Brich st','2026-08-10'),
('C121', 'Rahul Sharma', '45 MG Road', '2026-08-12'),
('C122', 'Priya Patel', '78 Shivaji Nagar', '2026-08-15'),
('C123', 'Amit Verma', '22 FC Road', '2026-08-18');


-- Task 10: List Employees with Their Branch Manager's Name and their branch details**
SELECT*
from branch
select*
from employees

SELECT
emp2.emp_name as employs,
b.manager_id,
emp.*
from 
employees as emp
 JOIN
branch as b
ON
emp.branch_id=b.branch_id
JOIN
employees as emp2
on b.manager_id= emp2.emp_id

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 5
create TABLE  rental_price_of_each_book AS
SELECT
book_title,
rental_price
FROM
books
WHERE
rental_price >'5'

SELECT*
FROM
rental_price_of_each_book

-- Task 12: Retrieve the List of Books Not Yet Returned

SELECT
ist.issued_book_name as not_return_book,
ist.issued_member_id,
mbr.member_name
FROM
issued_status as ist
LEFT JOIN
return_status as rst 
on ist.issued_id=rst.issued_id
LEFT JOIN
members as mbr
ON
ist.issued_member_id=mbr.member_id
where 
rst.return_id is NULL


-- INSERT INTO book_issued in last 30 days
-- SELECT * from employees;
-- SELECT * from books;
-- SELECT * from members;
-- SELECT * from issued_status


INSERT INTO issued_status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id)
VALUES
('IS151', 'C118', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL '24 days',  '978-0-553-29698-2', 'E108'),
('IS152', 'C119', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL '13 days',  '978-0-553-29698-2', 'E109'),
('IS153', 'C106', 'Pride and Prejudice', CURRENT_DATE - INTERVAL '7 days',  '978-0-14-143951-8', 'E107'),
('IS154', 'C105', 'The Road', CURRENT_DATE - INTERVAL '32 days',  '978-0-375-50167-0', 'E101');

-- Adding new column in return_status

ALTER TABLE return_status
ADD Column book_quality VARCHAR(15) DEFAULT('Good');

UPDATE return_status
SET book_quality = 'Damaged'
WHERE issued_id 
    IN ('IS112', 'IS117', 'IS118');
SELECT * FROM return_status;


/*
### Advanced SQL Operations

Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period).
 Display the member's name, book title, issue date, and days overdue.
*/

--issued_status joint with member and member joint with book and then we connect retun status
--filter out book that is retur
--if overduve is >30 day the issue day is less than 30 day it not cosider as not overdue


SELECT
ist.issued_member_id,
m.member_name,
b.book_title,
ist.issued_date,
rst.return_date,
CURRENT_DATE-ist.issued_date as over_due_days
FROM issued_status as ist 
inner join members as m 
on  m.member_id = ist.issued_member_id 
INNER join books as b 
on b.isbn =ist.issued_book_isbn
LEFT join --here we used left joint because inner joint make the that intrres that is commen in all
return_status as rst 
on rst.issued_id =ist.issued_id
WHERE
rst.return_date is NULL
AND
CURRENT_DATE-ist.issued_date >30


--Task 14: Update Book Status on Return
--Write a query to update the status of books in the books table to "available" when they are returned (based on entries in the return_status table).

--store prosudure
CREATE or REPLACE  procedure add_return_record (p_return_id varchar(10),p_issued_id varchar(10), p_book_quality varchar(15))
language plpgsql
as $$

declare
 v_isbn varchar(50);
 v_book_name varchar(80);

begin
--all logic and procedure we are gone do are come here
--inserting into return based on user input
INSERT into return_status (return_id, issued_id, return_date, book_quality)
VALUES(p_return_id, p_issued_id, CURRENT_DATE, p_book_quality);
        --update status in books
-- we create the tempery system for geting isbn for the status update through veriable 
SELECT 
issued_book_isbn,
issued_book_name
into 
v_isbn,
v_book_name
FROM 
 issued_status
WHERE 
issued_id= p_issued_id;

UPDATE books
SET status = 'yes'
WHERE isbn = v_isbn;
--for the notification that book has been updated
RAISE notice 'thank you for the returning the book : %',v_book_name ;  

end;
$$
--after this next person only do the isert the record
call add_return_records ();


--Testing FUNCTION add_return_records
issued_id= IS135
ISBN = WHERE isbn= '978-0-307-58837-1'

SELECT * FROM books
WHERE isbn ='978-0-307-58837-1'

SELECT* FROM issued_status
WHERE issued_book_isbn =' 978-0-307-58837-1';

DELETE FROM return_status
WHERE issued_id= 'IS135'

--working function
call add_return_record('R138', 'IS135','good');

/*
Task 15: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
*/
---SELECT*FROM branch
--SELECT* FROM issued_status
--SELECT*FROM employees
SELECT* FROM books
--SELECT* from return_status

CREATE TABLE branch_rport AS

SELECT
b.branch_id,
b.manager_id,
count(ist.issued_id) as number_of_book_issued,
count(rst.return_id) as number_of_book_return,
sum(bk.rental_price) as total_revenue
FROM 
issued_status as ist 
JOIN 
employees as emp
on emp.emp_id = ist.issued_emp_id
join
branch as b
on b.branch_id=emp.branch_id
left join
return_status as rst
on rst.issued_id =ist.issued_id
join
books as bk
on ist.issued_book_isbn=bk.isbn
GROUP BY
b.branch_id,
b.manager_id

select* from branch_rport

/*
Task 16: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 6 months.
*/
CREATE TABLE active_members as
SELECT * from members
WHERE member_id in (
SELECT
issued_member_id
FROM
issued_status
WHERE
issued_date > CURRENT_DATE - interval '6 month'
)
SELECT * from 
active_members

/*
Task 17: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.
*/

SELECT
emp.emp_name,
b.*,
count(ist.issued_id) as number_of_book_issed
FROM
issued_status as ist 
join 
employees as emp 
on emp.emp_id = ist.issued_emp_id
join
branch as b
on emp.branch_id=b.branch_id
GROUP BY 1,2

/*
Task 18: Identify Members Issuing High-Risk Books
Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. Display the member name, book title, and the number of times they've issued damaged books. */
SELECT* FROM return_status
SELECT* FROM issued_status
SELECT* FROM members

SELECT
m.member_id,
m.member_name,
ist.issued_book_name,
count(ist.issued_id) as damaged_book
FROM 
issued_status as ist
JOIN
return_status as rst
on rst.issued_id = ist.issued_id
join
members as m
on ist.issued_member_id=m.member_id
WHERE
rst.book_quality='Damaged'
GROUP BY 1,3
-- if find more tha two book you need to run 
HAVING
count(ist.issued_id) >2

/*
Task 19: Stored Procedure
Objective: Create a stored procedure to manage the status of books in a library system.
    Description: Write a stored procedure that updates the status of a book based on its issuance or return. Specifically:
    If a book is issued, the status should change to 'no'.
    If a book is returned, the status should change to 'yes'.
*/
SELECT* from books
SELECT * from issued_status

create or replace procedure issue_book(p_issued_id varchar(10),p_issued_member_id varchar(30),p_issued_book_isbn varchar(30),p_issued_emp_id varchar(10))
language plpgsql
as 
$$
declare
--all vairable delcare here
v_status varchar(10);

BEGIN
--all code we write here
    select 
    status
    into 
    v_status
    from books
    where isbn= p_issued_book_isbn;

    -- if avilabel logic
if v_status ='yes' then
        insert into issued_status(issued_id, issued_member_id,issued_date, issued_book_isbn,issued_emp_id)
        VALUES
        (p_issued_id ,p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);
    
        UPDATE books
        SET status = 'no'
        WHERE isbn = p_issued_book_isbn;
        RAISE notice 'book record added sucessfully for book_isbn:%',p_issued_book_isbn;
ELSE --else not avilabe then logiv=c
        RAISE notice 'soory to inform you the book you requested is unavilable book_isbn:%',p_issued_book_isbn;
END if;
END;
$$


--testing
SELECT* FROM books
--978-0-375-41398-8 is no
--978-0-14-044930-3 is yes

SELECT* from issued_status
--WHERE issued_book_isbn ='978-0-375-41398-8' --for issuedd id is IS134 member id C107
WHERE issued_book_isbn ='978-0-14-044930-3' --for issuedd id is IS115 member_id C109

CALL issue_book('IS175', 'C108', '978-0-553-29698-2', 'E104');

--for every now intery we need to inter new issued_id and for every return we need to retun_id

/*
Task 20: Create Table As Select (CTAS)
Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include:
    The number of overdue books.
    The total fines, with each day's fine calculated at $0.50.
    The number of books issued by each member.
    The resulting table should show:
    Member ID
    Number of overdue books
    Total fines */
     
     CREATE TABLE resulting_table AS

     SELECT
     ist.issued_member_id,
     count(*) as over_due_books,
     sum((CURRENT_DATE-ist.issued_date)*0.50) as total_fine
    FROM
    issued_status as ist
    left JOIN
    return_status as rst 
    ON rst.issued_id=ist.issued_id
    WHERE rst.return_date is NULL
    and CURRENT_DATE-ist.issued_date > 30
    GROUP BY
    ist.issued_member_id
    ORDER BY
    sum((CURRENT_DATE-ist.issued_date)*0.50) DESC

    SELECT* FROM resulting_table
