CREATE TABLE Compras (
    ID SERIAL PRIMARY KEY,
    Data DATE,
    Quantidade INT
);

INSERT INTO Compras (Data, Quantidade)
VALUES
    ('2023-10-20', 10),
    ('2023-10-20', 5),
    ('2023-10-21', 8),
    ('2023-10-21', 12),
    ('2023-10-22', 7);

-- Função para o levantamento diário de produtos
CREATE OR REPLACE FUNCTION LevantamentoDiarioProdutos()
RETURNS TABLE(DataRelatorio DATE, QuantidadeTotal BIGINT) AS $$
BEGIN
    RETURN QUERY
    SELECT Data, SUM(Quantidade) AS QuantidadeTotal
    FROM Compras
    GROUP BY Data;
END;
$$ LANGUAGE plpgsql;

-- Chame a função para gerar o relatório diário
SELECT * FROM LevantamentoDiarioProdutos();
