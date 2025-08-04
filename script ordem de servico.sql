-- criação de tabelas do projeto ordem de serviço

create database Ordem_servico;
use Ordem_servico;

create table CLIENTE (
    idCliente INT PRIMARY KEY,
    Nome VARCHAR(45),
    Telefone VARCHAR(45),
    Endereco VARCHAR(45)
);

create table VEICULO (
    idVeiculo INT PRIMARY KEY,
    Placa VARCHAR(45),
    Modelo VARCHAR(45),
    Ano VARCHAR(45),
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES CLIENTE(idCliente)
);

create table ORDEM_DE_SERVICO (
    idOrdem_de_servico INT PRIMARY KEY,
    Numero_OS VARCHAR(45),
    Data_Emissao VARCHAR(45),
    Data_Conclusao VARCHAR(45),
    Valor_Total VARCHAR(45),
    Status VARCHAR(45),
    Veiculo_idVeiculo INT,
    FOREIGN KEY (Veiculo_idVeiculo) REFERENCES VEICULO(idVeiculo)
);

create table SERVICO (
    idServico INT PRIMARY KEY,
    Descricao VARCHAR(45),
    Valor_mao_de_obra VARCHAR(45)
);

create table ORDEM_DE_SERVICO_HAS_SERVICO (
    Ordem_de_servico_idOrdem_de_servico INT,
    Ordem_de_servico_Veiculo_idVeiculo INT,
    Servico_idServico INT,
    Quantidade VARCHAR(45),
    PRIMARY KEY (Ordem_de_servico_idOrdem_de_servico, Servico_idServico),
    FOREIGN KEY (Ordem_de_servico_idOrdem_de_servico) REFERENCES ORDEM_DE_SERVICO(idOrdem_de_servico),
    FOREIGN KEY (Servico_idServico) REFERENCES SERVICO(idServico)
);

create table PECA (
    idPeca INT PRIMARY KEY,
    Descricao VARCHAR(45),
    Valor_unitario VARCHAR(45)
);

create table ORDEM_DE_SERVICO_HAS_PECA (
    Ordem_de_servico_idOrdem_de_servico INT,
    Ordem_de_servico_Veiculo_idVeiculo INT,
    Peca_idPeca INT,
    Quantidade VARCHAR(45),
    PRIMARY KEY (Ordem_de_servico_idOrdem_de_servico, Peca_idPeca),
    FOREIGN KEY (Ordem_de_servico_idOrdem_de_servico) REFERENCES ORDEM_DE_SERVICO(idOrdem_de_servico),
    FOREIGN KEY (Peca_idPeca) REFERENCES PECA(idPeca)
);

create table EQUIPE (
    idEquipe INT PRIMARY KEY,
    Nome_da_equipe VARCHAR(45),
    Ordem_de_servico_idOrdem_de_servico INT,
    Ordem_de_servico_Veiculo_idVeiculo INT,
    FOREIGN KEY (Ordem_de_servico_idOrdem_de_servico) REFERENCES ORDEM_DE_SERVICO(idOrdem_de_servico)
);

create table MECANICO (
    idMecanico INT PRIMARY KEY,
    Nome VARCHAR(45),
    Especialidade VARCHAR(45),
    Equipe_idEquipe INT,
    FOREIGN KEY (Equipe_idEquipe) REFERENCES EQUIPE(idEquipe)
);

-- inserção de dados

INSERT INTO Cliente (idCliente, Nome, telefone, Endereco) VALUES
(1, 'João Silva', '11999998888', 'Rua das Flores, 123'),
(2, 'Maria Oliveira', '11988887777', 'Av. Brasil, 456');

INSERT INTO Veiculo (idVeiculo, Placa, Modelo, Ano, Cliente_idCliente) VALUES
(1, 'ABC1234', 'Ford Ka', '2018', 1),
(2, 'XYZ9876', 'Toyota Corolla', '2020', 2);

INSERT INTO Ordem_de_servico (idOrdem_de_servico, Numero_OS, Data_Emissao, Data_Conclusao, Valor_Total, Status, Veiculo_idVeiculo) VALUES
(1, 'OS1001', '2025-07-01', '2025-07-02', '850.00', 'Concluído', 1),
(2, 'OS1002', '2025-07-05', NULL, '0.00', 'Em andamento', 2);

desc servico;

INSERT INTO Servico (idServico, Descricao, Valor_mao_de_obra) VALUES
(1, 'Troca de óleo', '100.00'),
(2, 'Revisão de freios', '250.00');

INSERT INTO Ordem_de_servico_has_Servico (Ordem_de_servico_idOrdem_de_servico, Ordem_de_servico_Veiculo_idVeiculo, Servico_idServico, Quantidade) VALUES
(1, 1, 1, '1'),
(1, 1, 2, '1');

INSERT INTO Peca (idPeca, Descricao, Valor_unitario) VALUES
(1, 'Filtro de óleo', '50.00'),
(2, 'Pastilhas de freio', '150.00');

INSERT INTO Ordem_de_servico_has_Peca (Ordem_de_servico_idOrdem_de_servico, Ordem_de_servico_Veiculo_idVeiculo, Peca_idPeca, Quantidade) VALUES
(1, 1, 1, '1'),
(1, 1, 2, '1');

INSERT INTO Equipe (idEquipe, Nome_da_equipe, Ordem_de_servico_idOrdem_de_servico, Ordem_de_servico_Veiculo_idVeiculo) VALUES
(1, 'Equipe Alfa', 1, 1),
(2, 'Equipe Beta', 2, 2);

INSERT INTO Mecanico (idMecanico, Nome, Especialidade, Equipe_idEquipe) VALUES
(1, 'Carlos Mendes', 'Freios', 1),
(2, 'Ana Lima', 'Motor', 1),
(3, 'Roberto Souza', 'Troca de óleo', 2);

-- Consultas
-- Listar todos os clientes com seus veículos

SELECT c.Nome, v.Placa, v.Modelo, v.Ano
FROM CLIENTE c
JOIN VEICULO v ON c.idCliente = v.Cliente_idCliente;


-- Consultar ordens de serviço concluídas

SELECT Numero_OS, Data_Emissao, Data_Conclusao, Valor_Total
FROM ORDEM_DE_SERVICO
WHERE Status = 'Concluído';

-- Ver serviços executados em uma ordem específica

SELECT s.Descricao, s.Valor_mao_de_obra, os_sv.Quantidade
FROM ORDEM_DE_SERVICO_HAS_SERVICO os_sv
JOIN SERVICO s ON os_sv.Servico_idServico = s.idServico
WHERE os_sv.Ordem_de_servico_idOrdem_de_servico = 1;

-- Ver peças usadas em uma ordem especifica

SELECT p.Descricao, p.Valor_unitario, os_pc.Quantidade
FROM ORDEM_DE_SERVICO_HAS_PECA os_pc
JOIN PECA p ON os_pc.Peca_idPeca = p.idPeca
WHERE os_pc.Ordem_de_servico_idOrdem_de_servico = 1;

-- Mostrar esquipe e mecânicos envolvidos em uma ordem

SELECT e.Nome_da_equipe, m.Nome AS Mecanico, m.Especialidade
FROM EQUIPE e
JOIN MECANICO m ON e.idEquipe = m.Equipe_idEquipe
WHERE e.Ordem_de_servico_idOrdem_de_servico = 1;

-- valor total de mão de bobra em uma ordem

SELECT SUM(CAST(s.Valor_mao_de_obra AS DECIMAL(10,2))) AS Total_Mao_de_Obra
FROM ORDEM_DE_SERVICO_HAS_SERVICO os_sv
JOIN SERVICO s ON os_sv.Servico_idServico = s.idServico
WHERE os_sv.Ordem_de_servico_idOrdem_de_servico = 1;
