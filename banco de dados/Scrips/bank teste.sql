-- explorando os comando ddl

select now() as Timestamp;

create  database if not exists manipulation;
use manipulation;

create table bankAccounts (
	Id_account int auto_increment primary key,
    Ag_num int not null,
    Ac_num int not null,
    Saldo float,
    constraint identification_account_constraint unique (Ag_num, Ac_num)
);

alter table bankAccounts add LimiteCretido float not null default 500.00;

insert into bankAccounts values (1,235,456787,0);
desc bankAccounts;


create table bankClient(
	Id_client int auto_increment,
    ClientAccount int,
    CPF char(11) not null,
    RG char(9) not null,
    Endereço varchar(50) not null,
    Renda_mensal float,
    primary key (Id_Client, ClientAccount),
    constraint fk_account_client foreign key (ClientAccount) references bankAccounts(Id_account)
    on update cascade
);

create table bankTransactions(
	Id_transaction int auto_increment primary key,
    Ocorrencia datetime,
    Status_transaction varchar(20),
    Valor_transaction float,
    Source_account int,
    Destination_account int,
    constraint fk_source_transation foreign key (Source_account) references bankAccount(Id_account),
    constraint fk_destination_transaction foreign key (Destination_account) references bankAccount(Id_account)
    on update cascade
);


