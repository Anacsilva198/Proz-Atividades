-- Crie uma base de dados chamada "MinhaEmpresa"
CREATE DATABASE MinhaEmpresa;

-- Use a base de dados
\c MinhaEmpresa;

-- Crie a tabela "Clientes" com uma coluna de ID auto incremento
CREATE TABLE Clientes (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    Email VARCHAR(255),
    Telefone VARCHAR(15)
);

-- Crie a tabela "Pedidos" com uma coluna de ClienteID que é uma chave estrangeira referenciando Clientes
CREATE TABLE Pedidos (
    ID SERIAL PRIMARY KEY,
    ClienteID INT,
    Produto VARCHAR(255),
    Quantidade INT,
    DataPedido DATE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);

-- Insira dados na tabela "Clientes"
INSERT INTO Clientes (Nome, Email, Telefone)
VALUES
    ('João', 'joao@email.com', '(11) 1234-5678'),
    ('Maria', 'maria@email.com', '(22) 9876-5432');

-- Insira dados na tabela "Pedidos"
INSERT INTO Pedidos (ClienteID, Produto, Quantidade, DataPedido)
VALUES
    (1, 'Produto A', 3, '2023-10-15'),
    (2, 'Produto B', 2, '2023-10-16');
    
--Utilize os comandos Joins para realizar consultas nas tabelas. 

SELECT Clientes.Nome, Pedidos.Produto
FROM Clientes
INNER JOIN Pedidos ON Clientes.ID = Pedidos.ClienteID;

SELECT Clientes.Nome, Pedidos.Produto
FROM Clientes
LEFT JOIN Pedidos ON Clientes.ID = Pedidos.ClienteID;

SELECT Clientes.Nome, Pedidos.Produto
FROM Clientes
RIGHT JOIN Pedidos ON Clientes.ID = Pedidos.ClienteID;

SELECT Clientes.Nome, Pedidos.Produto
FROM Clientes
FULL OUTER JOIN Pedidos ON Clientes.ID = Pedidos.ClienteID;

SELECT Clientes.Nome, Pedidos.Produto
FROM Clientes
CROSS JOIN Pedidos;




