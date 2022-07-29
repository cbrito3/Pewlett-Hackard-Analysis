-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

-- Creating tables for Employees
CREATE TABLE employees (
	empt_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (empt_no)
);
-- Creating tables for dept_manager
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    empt_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (empt_no) REFERENCES employees (empt_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (empt_no, dept_no)
);
-- Creating tables for salaries
CREATE TABLE salaries (
  empt_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (empt_no) REFERENCES employees (empt_no),
  PRIMARY KEY (empt_no)
);

-- Creating tables for dept_emp
CREATE TABLE dept_emp (
dept_no VARCHAR(4) NOT NULL,
  empt_no INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
FOREIGN KEY (empt_no) REFERENCES employees (empt_no),
	PRIMARY KEY (empt_no, dept_no)
); 

-- Creating tables for titles
CREATE TABLE titles (
  empt_no INT NOT NULL,
  titles VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
FOREIGN KEY (empt_no) REFERENCES employees (empt_no),
	 PRIMARY KEY (empt_no)
);

SELECT * FROM departments;

SELECT * FROM employees;

SELECT * FROM salaries;

SELECT * FROM dept_manager;

DROP TABLE titles CASCADE;

-- Creating tables for titles
CREATE TABLE titles (
empt_no INT NOT NULL,
	title VARCHAR NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (empt_no) REFERENCES employees (empt_no)
);

SELECT * FROM titles;

DROP TABLE dept_emp CASCADE;

-- Creating tables for dept_emp
CREATE TABLE dept_emp (
  empt_no INT NOT NULL,
  dept_no VARCHAR(4) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
FOREIGN KEY (empt_no) REFERENCES employees (empt_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  PRIMARY KEY (empt_no, dept_no)
);

SELECT * FROM dept_emp;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;
------dropping table, because we originally created this table from a query, we
-----haven't formed any connections to other tables and the CASCADE constraint isn't needed
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT empt_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.empt_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables-Use Left Join to Capture retirement-info Table
SELECT retirement_info.empt_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.empt_no = dept_emp.empt_no;

------ Use Aliases for Code Readability
SELECT ri.empt_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.empt_no = de.empt_no;


SELECT d.dept_name,
     dm.empt_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-----Use Left Join for retirement_info and dept_emp tables

SELECT ri.empt_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.empt_no = de.empt_no
WHERE de.to_date = ('9999-01-01');

----7.3.4 Use Count, Group By, and Order By

-- Employee count by department number
SELECT COUNT(ce.empt_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.empt_no = de.empt_no
GROUP BY de.dept_no;

-- Employee count by department number To order
SELECT COUNT(ce.empt_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.empt_no = de.empt_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

---7.3.5 Create Additional Lists
SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT empt_no,
    first_name,
last_name,
    gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT e.empt_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
---Before we create a temporary table using this code, comment out the INTO line.
--Highlight the INTO emp_info line and press Command + forward slash, / (for Mac)
-- INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.empt_no = s.empt_no)
INNER JOIN dept_emp as de
ON (e.empt_no = de.empt_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
 AND (de.to_date = '9999-01-01');
 
--List 2: Management
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.empt_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
-- comment out the INTO line before we run the code for the first time.
-- INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.empt_no = ce.empt_no);
		
--List 3: Department Retirees
SELECT ce.empt_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.empt_no = de.empt_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

--7.3.6 Create a Tailored List #SKILL DRILL
-- List of retirees per sales department
SELECT r.empt_no,r.first_name, r.last_name, d.dept_name
-- INTO sales_dept_info
FROM retirement_info as r
INNER JOIN dept_emp AS de
ON (r.empt_no = de.empt_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

-- List of retirees per sales and development department #SKILL DRILL
SELECT r.empt_no,r.first_name, r.last_name, d.dept_name
-- INTO sales_development_dept_info
FROM retirement_info as r
INNER JOIN dept_emp AS de
ON (r.empt_no = de.empt_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development');