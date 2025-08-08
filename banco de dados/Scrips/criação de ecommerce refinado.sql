-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

insert into clients(Fname, Minit, Lname, CPF, Address) 
	values('Maria','M', 'Silva', 123456789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		  ('Matheus','O', 'Pimentel', 987654321, 'rua alemeda289, Centro - Cidade das flores'),
          ('Ricardo','F', 'Silva', 456789123, 'avenida alemeda vinha 1009, Centro - Cidade das flores'),
          ('Julia','S', 'França', 789123456, 'rua lareijras 861, Centro - Cidade das flores'),
          ('Roberta','G', 'Assis', 98745631, 'avenida de koller 19, Centro - Cidade das flores'),
          ('Isabela','M', 'Cruz', 654789123, 'rua alemeda das flores 28, Centro - Cidade das flores');

select * from clients;

-- idProduct, Pname, classification_kids boolean, category(Eletrônico, Vestimenta, Brinquedos, Alimentos, Móveis), rate, size

insert into product (Pname,Classification_kids,category,rate,size)
	values('Fone de ouvido',False,'Eletrônico','4', null),
		  ('Barbie Elsa',True,'Brinquedos','3', null),
          ('Body Carters',True,'Vestimenta','5', null),
          ('Micronfone Vedo - Youtuber',False,'Eletrônico','4', null),
          ('Sofá retrátil',False,'Móveis','3', '3x57x80'),
          ('Farinha de arroz',False,'Alimentos','2', null),
          ('Fire Stick Amazon',False,'Eletrônico','3', null);

-- idOrder,idOrderClient,orderStatus,orderDescription,sendValue, PaymentCash bool
insert into orders(idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) 
	values (1, default,'compra via aplicativo', null, 1),
		   (2, default,'compra via aplicativo', 50, 0),
           (3, 'Confirmado',null, null, 1),
           (4, default,'compra via web site', 150, 0);
 
 select * from orders;
 delete from orders where idOrderClient in (1,2,3,4);
 
 -- idPOproduct,idPOorder, poQuantity,poStatus
 insert into productOrder (idPOproduct,idPOorder,poQuantity,poStatus)
	values(1,5,2,null),
		  (2,5,2,null),
          (3,6,2,null);
-- storageLocation, quantity
insert into productStorage (storageLocation,quantity)
	values('Rio de Janeiro', '1000'),
		  ('Rio de Janeiro', '500'),
          ('São Paulo', '10'),
          ('São Paulo', '100'),
          ('São Paulo', '10'),
          ('Brasília', '60');

-- idLproduct,idLstorage,location
insert into storageLocation (idLproduct,idLstorage,location)
	values (1,2,'RJ'),
		   (2,6,'GO');

-- idSupplier,SocialName, CNPJ,contact
insert into supplier (SocialName,CNPJ,contact)
	values ('Almeida e filhos', 123456789123456,'21985475'),
		   ('Eletrônicos Silva', 85451964914357,'21985484'),
           ('Eletrônicos Valma', 934567893934695,'21975474');
           
select * from supplier;
desc seller;

-- idSeller, SocialName, AbstName, CNPJ,CPF,location,contact
insert into seller (SocialName, AbstName, CNPJ,CPF,location,contact)
	values('Tech eletronics', null, 123456789456321,null, 'Rio de Janeiro', 219946287),
		  ('Botique Durgas', null,123456783778912, null,'Rio de Janeiro', 219567895),
          ('Kids World', null, 456789123654485,null, 'São Paulo', 1198657484);

select * from seller;

-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity)
	values(7,6,80),
		  (8,7,10);
       
select * from clients c, orders o 
desc productSeller;
-- recuperação de pedido com produtos
select c.idClient, Fname, count(*) as Number_of_order from clients c
	inner join orders o ON c.idClient = o.idOrderClient
    inner join productOrder p on p.idPOorder = o.idOrder
    group by idClient;

select concat(Fname, ' ', Lname) as Client ,idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = o.idOrderClient;
-- criar tabela cliente

create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit varchar(3),
    Lname varchar(20),
    CPF char(11) not null,
    address varchar(255),
    constraint unique_cpf_client unique (CPF)    
);

alter table clients auto_increment=1;

-- criar tabela client_pf
CREATE TABLE client_pf (
    idClient INT PRIMARY KEY,
    CPF CHAR(11) UNIQUE NOT NULL,
    FOREIGN KEY (idClient) REFERENCES clients(idClient)
);

-- criar tabela client_pj
CREATE TABLE client_pj (
    idClient INT PRIMARY KEY,
    CNPJ CHAR(14) UNIQUE NOT NULL,
    companyName VARCHAR(100) NOT NULL,
    FOREIGN KEY (idClient) REFERENCES clients(idClient)
);


-- criar tabela produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(80) not null,
    classification_kids bool,
    category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis'),
    rate float,
    size varchar(10)    
);

-- criar tabela pagamento
-- desafio: termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso , reflita essa modificação no esquema relacional ( diagrama )
-- criar constraints relacionadas ao pagamento


CREATE TABLE payment (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    typePayment ENUM('Boleto', 'Cartão', 'Dois cartões') NOT NULL,
    limitAvailable FLOAT,
    valuePaid FLOAT NOT NULL,
    paymentDate DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE order_payment (
    idOrder INT,
    idPayment INT,
    PRIMARY KEY (idOrder, idPayment),
    constraint fk_OPm_idOrder FOREIGN KEY (idOrder) REFERENCES orders(idOrder),
    constraint fk_OPm_idPayment FOREIGN KEY (idPayment) REFERENCES payment(idPayment)
);

-- criar tabela  de delivery

CREATE TABLE delivery (
    idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    idOrder INT UNIQUE,
    trackingCode VARCHAR(50),
    deliveryStatus ENUM('Pendente', 'Enviado', 'Em trânsito', 'Entregue', 'Cancelado') DEFAULT 'Pendente',
    FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);


-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderstatus enum('Cancelado', 'Confirmado', 'Em processamento') default'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10, 
    paymentCash bool default false,       
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
            
);
desc orders;
-- criar tabela estoque
create table ProductStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0  
);

-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,  
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
desc supplier;
-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialNme varchar(255) not null,
    AbstName varchar(255),
	CNPJ char(15) not null,
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

-- criando tabelas de relacionamento de produtos vendedor
create table productSeller (
	idPseller int,
    idPproduct int,
    ProdQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

desc productSeller;
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idPOproduct,idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);


create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key(idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier (
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

desc productSupplier;

show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';