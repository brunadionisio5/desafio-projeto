CREATE DATABASE company_constraints;
USE company_constraints;

-- EMPLOYEE
CREATE TABLE employee (
  Fname varchar(15) NOT NULL,
  Minit char(1),
  Lname varchar(15) NOT NULL,
  Ssn char(9) NOT NULL PRIMARY KEY,
  Bdate date,
  Address varchar(30),
  Sex char(1),
  Salary decimal(10,2) CHECK (Salary > 2000.0),
  Super_ssn char(9),
  Dno int,
  FOREIGN KEY (Super_ssn) REFERENCES employee(Ssn)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- DEPARTMENT
CREATE TABLE department (
   Dname varchar(15) NOT NULL,
   Dnumber int NOT NULL PRIMARY KEY,
   Mgr_ssn char(9),
   Mgr_start_date date,
   Dept_create_date date,
   FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
);

-- DEPT_LOCATIONS
CREATE TABLE dept_locations (
  Dnumber int NOT NULL,
  Dlocation varchar(15) NOT NULL,
  PRIMARY KEY (Dnumber, Dlocation),
  FOREIGN KEY (Dnumber) REFERENCES department(Dnumber)
);

-- PROJECT
CREATE TABLE project (
  Pname varchar(15) NOT NULL UNIQUE,
  Pnumber int NOT NULL PRIMARY KEY,
  Plocation varchar(15),
  Dnum int,
  FOREIGN KEY (Dnum) REFERENCES department(Dnumber)
);

-- WORKS_ON
CREATE TABLE works_on (
  Essn char(9) NOT NULL,
  Pno int NOT NULL,
  Hours decimal(3,1),
  PRIMARY KEY (Essn, Pno),
  FOREIGN KEY (Essn) REFERENCES employee(Ssn),
  FOREIGN KEY (Pno) REFERENCES project(Pnumber)
);

-- DEPENDENT
CREATE TABLE dependent (
  Essn char(9) NOT NULL,
  Dependent_name varchar(15) NOT NULL,
  Sex char(1),
  Bdate date,
  Relationship varchar(8),
  PRIMARY KEY (Essn, Dependent_name),
  FOREIGN KEY (Essn) REFERENCES employee(Ssn)
);