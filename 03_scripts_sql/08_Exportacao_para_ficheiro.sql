-- Fazer contagem de registos na tabela core.satelite
SELECT COUNT(*) FROM core.satelite;

-- Visualizar registos da tabela core.satelite
SELECT id_satelite, nome, agencia, data_lancamento, estado
    FROM core.satelite;

-- Exportar dados da tabela para ficheiro CSV
COPY (
    SELECT id_satelite, nome, agencia, data_lancamento, estado
    FROM core.satelite
) TO 'E:\satelite.csv'
DELIMITER ','
CSV HEADER;

-- criando tabela temporária para testar reimportação 
CREATE TABLE satelite_check AS
SELECT * FROM core.satelite WHERE 1=0;

-- Testar reimportação do CSV
COPY public.satelite_check FROM 'E:\satelite.csv'
DELIMITER ',' CSV HEADER;

-- Validar a reimportação usando contagem de registos
SELECT COUNT(*) as total_de_registros FROM public.satelite_check;

-- Visualizar os registos importados
SELECT * FROM public.satelite_check;

