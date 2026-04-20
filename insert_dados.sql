USE company_constraints;

-- EMPLOYEES
INSERT INTO employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES 
('Carlos', 'M', 'Silva', '111223333', '1980-02-15', 'Rua A - SP', 'M', 52000, NULL, 1),
('Mariana', 'R', 'Souza', '222334444', '1988-07-10', 'Rua B - SP', 'F', 41000, '111223333', 5),
('Fernanda', 'L', 'Costa', '333445555', '1990-03-22', 'Rua C - SP', 'F', 42000, '111223333', 4),
('Lucas', 'P', 'Oliveira', '444556666', '1995-11-05', 'Rua D - SP', 'M', 30000, '222334444', 5),
('Rafael', 'K', 'Pereira', '555667777', '1987-09-18', 'Rua E - SP', 'M', 37000, '222334444', 5),
('Juliana', 'A', 'Lima', '666778888', '1992-06-30', 'Rua F - SP', 'F', 26000, '222334444', 5),
('Patricia', 'S', 'Alves', '777889999', '1985-01-12', 'Rua G - SP', 'F', 27000, '333445555', 4),
('Bruno', 'T', 'Rocha', '888990000', '1993-04-25', 'Rua H - SP', 'M', 28000, '333445555', 4);

-- DEPENDENTS
INSERT INTO dependent VALUES 
('222334444', 'Ana', 'F', '2010-05-10', 'Filha'),
('222334444', 'Pedro', 'M', '2008-09-20', 'Filho'),
('222334444', 'Clara', 'F', '1985-03-01', 'Cônjuge'),
('333445555', 'Marcos', 'M', '1980-12-12', 'Cônjuge'),
('444556666', 'João', 'M', '2015-07-07', 'Filho');

-- DEPARTMENTS
INSERT INTO department VALUES 
('Tecnologia', 5, '222334444', '2015-03-10', '2010-01-01'),
('Financeiro', 4, '333445555', '2018-06-01', '2015-01-01'),
('Diretoria', 1, '111223333', '2012-09-15', '2010-05-05');

-- LOCATIONS
INSERT INTO dept_locations VALUES 
(1, 'São Paulo'),
(4, 'Campinas'),
(5, 'Santos'),
(5, 'São Vicente');

-- PROJECTS
INSERT INTO project (Pname, Pnumber, Plocation, Dnum) VALUES
('SistemaWeb', 1, 'Santos', 5),
('AppMobile', 2, 'São Vicente', 5),
('DataWarehouse', 3, 'São Paulo', 5),
('Automacao', 10, 'Campinas', 4),
('Reestrutura', 20, 'São Paulo', 1);

-- WORKS_ON
INSERT INTO works_on (Essn, Pno, Hours) VALUES
('444556666', 1, 30.0),
('444556666', 2, 10.0),
('555667777', 3, 40.0),
('666778888', 1, 20.0),
('222334444', 2, 15.0),
('777889999', 10, 25.0),
('888990000', 10, 30.0),
('333445555', 3, 20.0);

-- CONSULTAS (ajustadas)

-- Funcionários
SELECT * FROM employee;

-- Funcionários com dependentes
SELECT e.Ssn, COUNT(d.Essn) AS qtd_dependentes
FROM employee e
JOIN dependent d ON e.Ssn = d.Essn
GROUP BY e.Ssn;

-- Buscar funcionário específico
SELECT Bdate, Address 
FROM employee
WHERE Fname = 'Lucas' AND Lname = 'Oliveira';

-- Funcionários do departamento Tecnologia
SELECT e.Fname, e.Lname, e.Address
FROM employee e
JOIN department d ON e.Dno = d.Dnumber
WHERE d.Dname = 'Tecnologia';

-- Projetos em Campinas
SELECT *
FROM project p
JOIN department d ON p.Dnum = d.Dnumber
WHERE Plocation = 'Campinas';

-- Nome completo e gerente
SELECT d.Dname AS Departamento, CONCAT(e.Fname, ' ', e.Lname) AS Gerente
FROM department d
JOIN employee e ON d.Mgr_ssn = e.Ssn;

-- Cálculo de INSS
SELECT Fname, Lname, Salary, ROUND(Salary * 0.011, 2) AS INSS
FROM employee;

-- Aumento para quem trabalha no projeto SistemaWeb
SELECT e.Fname, e.Lname, e.Salary * 1.1 AS novo_salario
FROM employee e
JOIN works_on w ON e.Ssn = w.Essn
JOIN project p ON w.Pno = p.Pnumber
WHERE p.Pname = 'SistemaWeb';