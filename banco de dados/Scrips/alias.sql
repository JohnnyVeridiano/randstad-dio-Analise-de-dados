use company_constraints;
show tables;

-- Dnumber: departament
desc departament;

-- retira a ambiguidade através do alias ou AS Statement
select Dname, l.Dlocation as Departament_name
	from departament as d, dept_locations as l
    where d.Dnumber = l.Dnumber;
    
    
-- expressão regular
select concat(Fname, ' ', Lname) as Employee from employee;