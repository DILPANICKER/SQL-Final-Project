
# LIBRARY MANAGEMENT SYSTEM
CREATE DATABASE library;
USE library;


# TABLE 1 BRANCH
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(250),
    Contact_no VARCHAR(15)
);
Desc Branch;

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES 
(1, 101, 'Trivandrum Central, Rail Street', '1234567890'),
(2, 102, 'Greater Cochin, HighCourt Street', '9876543210'),
(3, 103, 'Calicut Town, Mananchira', '5556667777');

Select * From Branch;

#Table 2 Employee
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

Desc Employee;

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES 
(101, 'Krish Srikanth', 'Manager', 70000, 1),
(102, 'Sunil Gavaskar', 'Manager', 75000, 2),
(103, 'Mohamed Azaruddin', 'Manager', 72000, 3),
(104, 'Dileep Vengsarkar', 'Librarian', 45000, 1),
(105, 'Ravi Shashtri', 'Assistant Librarian', 35000, 1),
(106, 'Kapi Dev', 'Librarian', 46000, 2),
(107, 'Mohinder Amarnath', 'Assistant Librarian', 37000, 3),
 (108, 'Chetan Chouhan', 'Librarian', 48000, 3),
(109, 'Maninder Singh', 'Assistant Librarian', 35000, 3),
(110, 'Shivlal yadav', 'Library Clerk', 30000, 3),
(111, 'Narendra Hirwani', 'Assistant Clerk', 25000, 3);

select * from Employee;

# Table 3 BOOKS
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,                
    Book_title VARCHAR(100),   
    Category VARCHAR(100),      
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),   
    Author VARCHAR(150),        
    Publisher VARCHAR(150),     
    Quantity INT                 
);

Desc Books;

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher, Quantity)
VALUES 
(111, 'Marketing Management', 'Marketing', 50, 'yes', 'Philip Kotler', 'Herald', 5),
(112, 'The History of Ancient Rome', 'History', 30, 'yes', 'Antony Cruz', 'Penguin', 3),
(113, 'Financial Management', 'Finance', 40, 'no', 'Jain and Narang', 'Universal', 4),
(114, 'Production Management', 'Production', 25, 'yes', 'O Chary', 'Deepika', 6),
(115, 'Managerial Economics', 'Economics', 60, 'no', 'Vashney Maheshwari', 'HHiggin Bothams', 4),
(116, 'Oranisation Behavior', 'Industrial psychology', 20, 'yes', 'Fred Luthans', 'Little, Brown', 3),
(117, 'A Brief History of Time', 'Science', 35, 'yes', 'Stephen Hawking', 'Bantam', 6),
(118, 'Indian History', 'History', 40, 'yes', 'Romila Thapar', 'Penguin India', 5),
(119, 'Manegerial Accounting', 'Accountancy', 45, 'yes', 'Krishna Murthy', 'DC Books', 4),
(120, 'Principles of Management', 'Human Resources', 45, 'yes', 'Koons and Odonnel', 'Prentice Hall', 4); 

select * from Books;

# Table 4 Customer
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
desc customer;

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
(201, 'Pradeep Shashi', '123 ABC Street', '2020-12-15'),
(202, 'Neethu Rajan', '456 DEF Street', '2021-05-10'),
(203, 'Saju Mukund', '789 GHI Street', '2022-02-20'),
(204, 'Blessi George', '012 JKL Street', '2023-03-18'),
(205, 'Muthu Kumaran', '112 MNO Street', '2021-11-25');

select * from customer;

# Table 5 ISSUESTATUS
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
Desc Issuestatus;

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
(301, 201, 'Marketing Management', '2023-06-10', 111),
(302, 202, 'Production Management', '2023-06-15', 114),
(303, 204, 'The History of Ancient Rome', '2023-06-20', 112);

select * from IssueStatus;

# Table 6 ReturnStatus
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
Desc ReturnStatus;

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES 
(401, 201, 'Marketing Management', '2023-06-25', 111),
(402, 202, 'Production Management', '2023-06-30', 114);

select * from ReturnStatus;


# 1. Retrieve the book title, category, and rental price of all available books. 
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'yes';


# 2.List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;


# 3. Retrieve the book titles and the corresponding customers who have issued those books
SELECT B.Book_title, C.Customer_name
FROM Books B
JOIN IssueStatus I ON B.ISBN = I.Isbn_book
JOIN Customer C ON I.Issued_cust = C.Customer_Id;

# 4. Display the total count of books in each category
SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;


# 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;


# 6. List the customer names who registered before 2022-01-01 and have not issued any books yet
SELECT Customer_name 
FROM Customer 
WHERE Reg_date < '2022-01-01' 
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);


# 7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no;


# 8. Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT C.Customer_name 
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust 
WHERE MONTH(I.Issue_date) = 6 AND YEAR(I.Issue_date) = 2023;


# 9. Retrieve book_title from book table containing history. 
SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%history%';


# 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees 
SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no 
HAVING COUNT(*) > 5;


# 11. Retrieve the names of employees who manage branches and their respective branch addresses. 
SELECT E.Emp_name, B.Branch_address 
FROM Employee E
JOIN Branch B ON E.Emp_Id = B.Manager_Id;


# 12. Display the names of customers who have issued books with a rental price higher than Rs. 25. 
SELECT DISTINCT C.Customer_name 
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
JOIN Books B ON I.Isbn_book = B.ISBN
WHERE B.Rental_Price > 25;



