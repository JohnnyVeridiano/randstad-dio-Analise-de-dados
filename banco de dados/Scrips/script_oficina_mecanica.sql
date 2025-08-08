
-- ==========================================
-- CRIAÇÃO DAS TABELAS (DDL)
-- ==========================================
DROP DATABASE IF EXISTS OficinaMecanica;
CREATE DATABASE OficinaMecanica;
USE OficinaMecanica;

CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    Nome VARCHAR(45),
    telefone VARCHAR(45),
    Endereco VARCHAR(45)
);

CREATE TABLE Veiculo (
    idVeiculo INT PRIMARY KEY,
    Placa VARCHAR(45),
    Modelo VARCHAR(45),
    Ano VARCHAR(45),
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Ordem_de_servico (
    idOrdem_de_servico INT PRIMARY KEY,
    Numero_OS VARCHAR(45),
    `Data Emissao` DATE,
    `Data Conclusao` DATE,
    `Valor Total` VARCHAR(45),
    Status VARCHAR(45),
    Veiculo_idVeiculo INT,
    FOREIGN KEY (Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo)
);

CREATE TABLE Servico (
    idServico INT PRIMARY KEY,
    Descrição VARCHAR(45),
    `Valor mao de obra` VARCHAR(45)
);

CREATE TABLE Ordem_de_servico_has_Servico (
    Ordem_de_servico_idOrdem_de_servico INT,
    Ordem_de_servico_Veiculo_idVeiculo INT,
    Servico_idServico INT,
    Quantidade VARCHAR(45),
    PRIMARY KEY (Ordem_de_servico_idOrdem_de_servico, Servico_idServico),
    FOREIGN KEY (Ordem_de_servico_idOrdem_de_servico) REFERENCES Ordem_de_servico(idOrdem_de_servico),
    FOREIGN KEY (Ordem_de_servico_Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (Servico_idServico) REFERENCES Servico(idServico)
);

CREATE TABLE Peca (
    idPeca INT PRIMARY KEY,
    Descrição VARCHAR(45),
    `Valor unitario` VARCHAR(45)
);

CREATE TABLE Ordem_de_servico_has_Peca (
    Ordem_de_servico_idOrdem_de_servico INT,
    Ordem_de_servico_Veiculo_idVeiculo INT,
    Peca_idPeca INT,
    Quantidade VARCHAR(45),
    PRIMARY KEY (Ordem_de_servico_idOrdem_de_servico, Peca_idPeca),
    FOREIGN KEY (Ordem_de_servico_idOrdem_de_servico) REFERENCES Ordem_de_servico(idOrdem_de_servico),
    FOREIGN KEY (Ordem_de_servico_Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (Peca_idPeca) REFERENCES Peca(idPeca)
);

CREATE TABLE Equipe (
    idEquipe INT PRIMARY KEY,
    `Nome da equipe` VARCHAR(45),
    Ordem_de_servico_idOrdem_de_servico INT,
    Ordem_de_servico_Veiculo_idVeiculo INT,
    FOREIGN KEY (Ordem_de_servico_idOrdem_de_servico) REFERENCES Ordem_de_servico(idOrdem_de_servico),
    FOREIGN KEY (Ordem_de_servico_Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo)
);

CREATE TABLE Mecanico (
    idMecanico INT PRIMARY KEY,
    Nome VARCHAR(45),
    Especialidade VARCHAR(45),
    Equipe_idEquipe INT,
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);

-- ==========================================
-- INSERÇÃO DE DADOS (DML)
-- ==========================================
INSERT INTO Cliente VALUES (1, 'João Silva', '11999998888', 'Rua das Flores, 123'),
                           (2, 'Maria Oliveira', '11988887777', 'Av. Brasil, 456');

INSERT INTO Veiculo VALUES (1, 'ABC1234', 'Ford Ka', '2018', 1),
                           (2, 'XYZ9876', 'Toyota Corolla', '2020', 2);

INSERT INTO Ordem_de_servico VALUES (1, 'OS1001', '2025-07-01', '2025-07-02', '850.00', 'Concluído', 1),
                                    (2, 'OS1002', '2025-07-05', NULL, '0.00', 'Em andamento', 2);

INSERT INTO Servico VALUES (1, 'Troca de óleo', '100.00'),
                           (2, 'Revisão de freios', '250.00');

INSERT INTO Ordem_de_servico_has_Servico VALUES (1, 1, 1, '1'),
                                                 (1, 1, 2, '1');

INSERT INTO Peca VALUES (1, 'Filtro de óleo', '50.00'),
                        (2, 'Pastilhas de freio', '150.00');

INSERT INTO Ordem_de_servico_has_Peca VALUES (1, 1, 1, '1'),
                                              (1, 1, 2, '1');

INSERT INTO Equipe VALUES (1, 'Equipe Alfa', 1, 1),
                          (2, 'Equipe Beta', 2, 2);

INSERT INTO Mecanico VALUES (1, 'Carlos Mendes', 'Freios', 1),
                            (2, 'Ana Lima', 'Motor', 1),
                            (3, 'Roberto Souza', 'Troca de óleo', 2);

-- ==========================================
-- CONSULTAS COMPLEXAS (SQL AVANÇADO)
-- ==========================================

-- 1. Recuperação simples
SELECT Nome, telefone FROM Cliente;

-- 2. Filtros com WHERE
SELECT * FROM Ordem_de_servico WHERE Status = 'Concluído';

-- 3. Expressão para atributo derivado: tempo de execução da ordem
SELECT idOrdem_de_servico, DATEDIFF(`Data Conclusao`, `Data Emissao`) AS Dias_execucao
FROM Ordem_de_servico
WHERE `Data Conclusao` IS NOT NULL;

-- 4. Ordenação por data de emissão
SELECT * FROM Ordem_de_servico ORDER BY `Data Emissao` DESC;

-- 5. Agrupamento e HAVING: contar serviços por ordem, apenas os que têm mais de 1
SELECT Ordem_de_servico_idOrdem_de_servico, COUNT(*) AS total_servicos
FROM Ordem_de_servico_has_Servico
GROUP BY Ordem_de_servico_idOrdem_de_servico
HAVING COUNT(*) > 1;

-- 6. Junção entre tabelas: listar ordens com cliente, veículo, equipe e total de peças
SELECT o.idOrdem_de_servico, c.Nome AS Cliente, v.Modelo, e.`Nome da equipe`, COUNT(p.idPeca) AS total_pecas
FROM Ordem_de_servico o
JOIN Veiculo v ON o.Veiculo_idVeiculo = v.idVeiculo
JOIN Cliente c ON v.Cliente_idCliente = c.idCliente
JOIN Equipe e ON e.Ordem_de_servico_idOrdem_de_servico = o.idOrdem_de_servico
LEFT JOIN Ordem_de_servico_has_Peca osp ON osp.Ordem_de_servico_idOrdem_de_servico = o.idOrdem_de_servico
LEFT JOIN Peca p ON p.idPeca = osp.Peca_idPeca
GROUP BY o.idOrdem_de_servico;
