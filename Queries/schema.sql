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
----------------------------------
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