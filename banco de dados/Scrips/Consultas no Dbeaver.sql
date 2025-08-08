select * from albums a ;

select count(*) from albums a;

select Albumid, Title from albums a where a.ArtistId ='Null';

SELECT * from artists ;

select a2.ArtistId, a2.Name, count(*) as Records from albums a inner join artists a2 group by 1 order by Records ASC;

SELECT a2.ArtistId, a2.Name, COUNT(*) AS Records
FROM albums a
INNER JOIN artists a2 ON a.ArtistId = a2.ArtistId
GROUP BY a2.ArtistId, a2.Name
ORDER BY Records ASC;

SELECT * FROM customers c limit 10;

Select c.State, count(*) as total from customers c group by 1 order by total DESC;

-- Quantos clientes moram na Broadway?
SELECT  Count(*) As total from customers c where Address like '%Broadway%';

-- Verificar company dos clientes

SELECT count(*)from Customers c where Company is not null;
SELECT Firstname from Customers c where Company is null;
SELECT * FROM employees e ;

-- Quais dos clientes são colaboradores
select c.FirstName from customers c 
	where Company is null and c.FirstName in(
	select e.FirstName from Employees e);

select c.FirstName, c.LastName from customers c inner join employees e where c.FirstName = e.FirstName ; 

-- Maior uantidade de vendas e maior preço 
select * from invoices i limit 10;
SELECT * FROM invoice_items ii order by ii.UnitPrice DESC LIMIT 10;

SELECT ii.UnitPrice, count(*) as Record FROM invoice_items ii GROUP BY ii.UnitPrice ;

-- Clientes que possuem invoices associados e quantidade para cada cliente

SELECT i.CustomerId, c.FirstName, count(*) as Record  from invoices i 
	INNER JOIN customers c on c.CustomerId = i.CustomerId
	GROUP BY i.CustomerId ORDER BY Record LIMIT 10; 

SELECT i.CustomerId, c.FirstName, count(*) as Record  from invoices i 
	INNER JOIN customers c on c.CustomerId = i.CustomerId
	GROUP BY i.CustomerId ORDER BY Record LIMIT 10; 
