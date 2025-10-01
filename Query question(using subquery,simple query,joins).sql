create database Pfile;
use pfile;

create table ibm (id int primary key,name varchar(20), salary double,dob date);
select * from ibm;

drop table ibm;

describe ibm;

insert into ibm values(1,'parth','45000','2004-04-04');

insert into ibm values(2,'arth','35000','2007-04-04');

select * from ibm
order by id desc;

select * from ibm where salary > 40000 and salary < 70000;

alter table ibm
drop column salary;

select * from ibm;

alter table ibm 
add column email varchar (30);


insert into ibm values(3,'parth','2004-04-04','parth@gmail.com');

delete from ibm where id = 1;

alter table ibm add salary double;

insert into ibm values(4,'parth','2004-04-04','parth@gmail.com','45000');
insert into ibm values(5,'rishi','2005-04-04','rishi@gmail.com','45000');
insert into ibm values(6,'rohit','2004-06-04','rohit@gmail.com','54000');

select sum(salary) as total_salary
from ibm;

create table reviews (review_id int ,user_id varchar(20),submit_date date,Product_id int ,stars int);
select * from reviews;

insert into reviews values( 1,101,'2025-02-04',10,4);
insert into reviews values( 2,102,'2025-12-04',12,5);
insert into reviews values( 3,103,'2025-04-04',13,3);

select User_id,stars from reviews;

create table books(title varchar(2), price int);
insert into books values('j',20);
insert into books values('c',90);
insert into books values('c+',150);
insert into books values('va',200);

select title,price from books 
where price >100
order by price desc;

alter table books add book_author varchar(20);
insert into books values('ja',20,'aaa');
insert into books values('c',90,'bbb');
insert into books values('c+',150,'ccc');
insert into books values('va',200,'ddd');
select * from books;

select title ,count(book_author)
as author from books b
join books as Bs on b.book_author = Bs.book_author
group by title;

-- Create Departments Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Create Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    active_status BOOLEAN,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Insert into Departments
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Sales');

-- Insert into Employees
INSERT INTO employees (emp_id, first_name, last_name, salary, active_status, dept_id) VALUES
(101, 'Alice', 'Johnson', 55000, TRUE, 1),
(102, 'Bob', 'Smith', 60000, TRUE, 2),
(103, 'Charlie', 'Brown', 45000, FALSE, 1),
(104, 'David', 'Wilson', 70000, TRUE, 3),
(105, 'Eve', 'Davis', 80000, TRUE, 3),
(106, 'Frank', 'Miller', 40000, TRUE, 4),
(107, 'Grace', 'Taylor', 65000, FALSE, 2),
(108, 'Hannah', 'Moore', 72000, TRUE, 4),
(109, 'Ian', 'Clark', 50000, TRUE, 2),
(110, 'Jane', 'Lewis', 90000, TRUE, 3);

-- 1. List all employees with their department names
select e.first_name,d.dept_name
from employees e
join departments d on e.dept_id= d.dept_id;

-- 2. Show all employees who are currently active
select * from employees
where active_status= true; 

-- 3. Find employees who earn more than 60,000
select first_name,salary 
from employees
where salary > 60000;

-- 4. Display the department with dept_id = 3 and all employees in it.
select d.dept_name,e.first_name ,e.last_name 
from employees e
join departments d on e.dept_id=d.dept_id
where d.dept_id=3;

  -- 5. Count how many employees are in each department.
  select d.dept_name ,count(*) from employees e
  join departments d on e.dept_id=d.dept_id
  group by d.dept_name;
  -- or --
  SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 6. Find the average salary of employees in each department 
  select d.dept_name,avg(salary) 
  from employees e
  join departments d on e.dept_id=d.dept_id
  group by d.dept_name;
  
  -- 7. Show the highest and lowest salary in the company
  select max(salary) as highest_salary,
  min(salary) as lowest_salary 
  from employees;
  
  -- 8. List departments where the average salary is greater than 65,000.
  select d.dept_name ,avg(e.salary)
  from departments d
  join employees e on d.dept_id=e.dept_id
  group by d.dept_name
having  avg(e.salary) > 65000;

-- 9. Show departments that have more than 2 active employees
select d.dept_name ,count(e.emp_id)
from departments d
join employees e on d.dept_id= e.dept_id
where e.active_status =true
group by d.dept_name
having count(e.emp_id)>2;

--  a) List all active employees with salary greater than ₹60,000:
select * from employees 
where active_status=true and salary > 60000;
 
 -- b) Find employees with salary between ₹50,000 and ₹80,000
 select * from employees
 where salary between 50000 and 80000;
 
 -- c) Show inactive employees or those earning less than ₹50,000
 select * from employees 
 where active_status=false
 and salary < 50000;
 
 -- d) Names starting with 'A'
 select * from employees
 where first_name like 'A%';
 
 -- e) Names containing 'an' anywhere
 SELECT * FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%AN%';
 
 -- f) Calculate a 10% salary increment
 SELECT * ,SALARY * 1.10 AS INCREMENT_SALARY 
 FROM EMPLOYEES;
 
 -- g) Calculate a 20% salary increment
 SELECT FIRST_NAME,LAST_NAME ,SALARY,
 SALARY * 1.20 FROM EMPLOYEES;
 
-- h) Average salary per department
SELECT D.DEPT_NAME , AVG(E.SALARY)
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPT_ID = D.DEPT_ID
group by D.DEPT_NAME;

-- i) Maximum salary per department
SELECT D.DEPT_NAME,MAX(E.SALARY)
FROM EMPLOYEES E 
JOIN DEPARTMENTS D ON E.DEPT_ID=D.DEPT_ID
GROUP BY D.DEPT_NAME; 

-- j) Employees earning more than their department’s average
SELECT * FROM EMPLOYEES E
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES
WHERE DEPT_ID=E.DEPT_ID );  
 
 SELECT AVG(SALARY) FROM EMPLOYEES;
 
 -- k) Employees in HR (dept_id = 1) or IT (dept_id = 3
 SELECT * FROM EMPLOYEES 
 WHERE DEPT_ID IN (1,3);

  -- l) Employees whose salary is greater than the minimum 
  -- salary of any department 
  SELECT *
  FROM EMPLOYEES 
WHERE SALARY > ANY(SELECT MIN(SALARY) FROM EMPLOYEES 
group by DEPT_ID);
 
 -- 
  CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    class INT
);

INSERT INTO students (student_id, name, class) VALUES
(1, 'Aakash', 10),
(2, 'Priya', 10),
(3,'Ravi',10),
(4,'Sneha', 10);


CREATE TABLE marks (
    id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(50),
    marks INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO marks (id, student_id, subject, marks) VALUES
(1, 1, 'Maths', 78),
(2, 1, 'Science', 82),
(3, 2, 'Maths', 88),
(4, 2, 'Science', 75),
(5, 3, 'Maths', 92),
(6, 3, 'Science', 89),
(7, 4, 'Maths', 67),
(8, 4,'Science',72);

-- 1. Find the average marks per student 
select s.name,avg(m.marks)
 from students s
 join marks m on s.student_id=m.student_id
 group by s.name;
 
 -- 2. Identify students whose marks are above the overall average.
 select distinct s.name,avg(m.marks)
 from students s
 join marks m on s.student_id=m.student_id
 where marks > (select avg(m.marks) from marks);

