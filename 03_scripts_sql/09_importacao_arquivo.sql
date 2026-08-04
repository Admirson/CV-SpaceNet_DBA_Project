-- Criar tabela temporária para testar importação 
CREATE TABLE core.satelite_tmp AS
SELECT * FROM core.satelite WHERE 1=0;

-- Importar dados de ficheiro CSV
COPY satelite_tmp (id_satelite, nome, agencia, data_lancamento, estado)
FROM 'E:\satelite.csv'
DELIMITER ','
CSV HEADER;

-- Validação da importação
-- Contar registos
SELECT COUNT(*) FROM satelite_tmp;

-- Comparar com tabela original
SELECT COUNT(*) FROM core.satelite;

-- Verificar se existem valores nulos em campos obrigatórios	
SELECT COUNT(*) FROM core.satelite_tmp WHERE nome IS NULL;
SELECT COUNT(*) FROM core.satelite_tmp WHERE agencia IS NULL;

-- Verificar se existem datas de lançamento inválidas (nulas ou futuras)
SELECT COUNT(*) FROM core.satelite_tmp WHERE data_lancamento IS NULL;
SELECT COUNT(*) FROM core.satelite_tmp WHERE data_lancamento > CURRENT_DATE;

-- Comparar valores únicos - chaves primárias
SELECT COUNT(DISTINCT id_satelite) FROM core.satelite_tmp;	
SELECT COUNT(DISTINCT id_satelite) FROM core.satelite;

-- Verificar se existem valores duplicados na tabela temporária	
SELECT id_satelite, COUNT(*) 
FROM core.satelite_tmp 
GROUP BY id_satelite 
HAVING COUNT(*) > 1;
