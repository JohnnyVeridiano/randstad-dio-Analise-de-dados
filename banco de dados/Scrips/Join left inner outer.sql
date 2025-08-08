use company_constraints;

-- JOIN statement
desc employee;
desc works_on;


-- JOIN
select * from employee JOIN works_on;

-- JOIN ON -> INNER JOIN ON

select * from employee JOIN works_on on Ssn = Essn;
select * from employee join departament on Ssn = Mgr_ssn;

select Fname, Lname, Address, Dname
	from (employee join departament on Dno=Dnumber)
    where Dname = 'Research';
    
 select * from dept_locations; -- Dlocation e Dnumber	
 select * from departament; -- Dname, Dept_create_date
 
 select Dname as Departament, Dept_create_date as Start_Date, Dlocation as Location
	from departament inner join dept_locations using(Dnumber)
        order by Start_Date;
 
-- CRONS JOIN - produto cartesiano
select * from employee cross join dependent;


-- JOIN com mais de 3 tableas
-- project, works_on e employee
select concat(Fname,' ', Lname) as Full_name, Dno as Dept_Number, Pname as Project_name,Pno as Project_number,Plocation as Location from employee
	inner join works_on on Ssn = Essn
    inner join project on Pno = Pnumber
    where Pname like 'Prod%'
    order by Pnumber;
    
    desc works_on;


-- departament, dept_location, employee
select Dnumber,Dname as Departament_name, concat(Fname, ' ', Lname) as Manager, Salary, round(Salary*0.05,2) as Bonus
 from departament 
    inner join dept_locations using(Dnumber)
    inner join employee on Ssn = Mgr_ssn
    group by Dnumber
    having count(*)>1
    ;
    
-- OUTER JOIN

select * from employee;
select * from dependent;
show tables;
select * from employee inner join dependent on Ssn = Essn;
select * from employee left join dependent on Ssn = Essn;

select * from employee left outer join dependent on Ssn = Essn;