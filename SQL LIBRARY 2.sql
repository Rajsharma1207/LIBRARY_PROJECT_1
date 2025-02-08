SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;


--PROJECT TASK


--Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books
(isbn , book_title , category , rental_price , status , author , publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;


--Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '125 main st'
WHERE member_id = 'C101';


--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issued_status
WHERE issued_id = 'IS121';


--Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101'


--Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT issued_member_id, COUNT(DISTINCT issued_book_name) AS count
FROM issued_status
GROUP BY  issued_member_id
HAVING count(DISTINCT issued_book_name) > 2


--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
CREATE TABLE count_cnts
AS
	SELECT b.isbn ,b.book_title, COUNT(isa.issued_id) AS no_issued
	FROM books AS b
	JOIN issued_status AS isa
	ON isa.issued_book_isbn = b.isbn
	GROUP BY 1 , 2


SELECT * FROM count_cnts


--Task 7. Retrieve All Books in a Specific Category:
SELECT category , SUM(rental_price) AS avg_sale
FROM books
GROUP BY 1 
HAVING category = 'Classic'


--Task 8: Find Total Rental Income by Category:
SELECT 
b.category, 
SUM(b.rental_price),
COUNT(*)
FROM books AS b
JOIN issued_status AS isc
ON isc.issued_book_isbn = b.isbn
GROUP BY 1 
ORDER BY 2 DESC


--List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days'


--List Employees with Their Branch Manager's Name and their branch details:
SELECT 
e.emp_id,
e.emp_name,
e.position,
e.salary,
b.*
FROM
employees AS e
JOIN branch AS b
ON e.branch_id = b.branch_id


--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE TABLE rental_above_6 AS
SELECT rental_price, category
FROM books
WHERE rental_price > 6

SELECT * FROM rental_above_6


--Task 12: Retrieve the List of Books Not Yet Returned
SELECT *
FROM issued_status AS isc
LEFT JOIN return_status AS rs
ON isc.issued_id = rs.issued_id 
WHERE return_id IS NULL

-----END PROJECT
---------THANKS









