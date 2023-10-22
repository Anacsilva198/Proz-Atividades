CREATE DATABASE loja_intrumentos;

\c loja_intrumentos;

CREATE TABLE InstrumentosMusicais (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    Tipo VARCHAR(100),
    Preco NUMERIC(10, 2)
);

CREATE TABLE RegistroDeInsercao (
    ID SERIAL PRIMARY KEY,
    TabelaAfectada VARCHAR(255),
    Acao VARCHAR(10),
    DataHora TIMESTAMP
);

INSERT INTO InstrumentosMusicais (Nome, Tipo, Preco)
VALUES
    ('Violino', 'Corda', 500.00),
    ('Guitarra', 'Corda', 800.00),
    ('Piano de Cauda', 'Teclado', 3500.00),
    ('Trompete', 'Sopro', 300.00),
    ('Bateria', 'Percussão', 1200.00);
    
INSERT INTO RegistroDeInsercao (TabelaAfectada, Acao, DataHora)
VALUES
    ('InstrumentosMusicais', 'INSERT', NOW()),
    ('RegistroDeInsercao', 'INSERT', NOW()),
    ('InstrumentosMusicais', 'INSERT', NOW()),
    ('RegistroDeInsercao', 'INSERT', NOW()),
    ('InstrumentosMusicais', 'INSERT', NOW());


-- Trigger para INSERT na tabela "InstrumentosMusicais"
CREATE OR REPLACE FUNCTION TriggerInsertInstrumento()
RETURNS TRIGGER AS $$
BEGIN
    -- Ação a ser executada após um INSERT
    INSERT INTO RegistroDeInsercao (TabelaAfectada, Acao, DataHora)
    VALUES ('InstrumentosMusicais', 'INSERT', NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER InsertTriggerInstrumento
AFTER INSERT ON InstrumentosMusicais
FOR EACH ROW
EXECUTE FUNCTION TriggerInsertInstrumento();

-- Trigger para UPDATE na tabela "InstrumentosMusicais"
CREATE OR REPLACE FUNCTION TriggerUpdateInstrumento()
RETURNS TRIGGER AS $$
BEGIN
    -- Ação a ser executada após um UPDATE
    INSERT INTO RegistroDeInsercao (TabelaAfectada, Acao, DataHora)
    VALUES ('InstrumentosMusicais', 'UPDATE', NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER UpdateTriggerInstrumento
AFTER UPDATE ON InstrumentosMusicais
FOR EACH ROW
EXECUTE FUNCTION TriggerUpdateInstrumento();

-- Trigger para DELETE na tabela "InstrumentosMusicais"
CREATE OR REPLACE FUNCTION TriggerDeleteInstrumento()
RETURNS TRIGGER AS $$
BEGIN
    -- Ação a ser executada após um DELETE
    INSERT INTO RegistroDeInsercao (TabelaAfectada, Acao, DataHora)
    VALUES ('InstrumentosMusicais', 'DELETE', NOW());
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER DeleteTriggerInstrumento
AFTER DELETE ON InstrumentosMusicais
FOR EACH ROW
EXECUTE FUNCTION TriggerDeleteInstrumento();




