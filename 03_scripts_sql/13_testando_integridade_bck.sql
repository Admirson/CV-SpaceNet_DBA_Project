--Verificar se existem valores nulos em campos obrigatórios
SELECT COUNT(*) FROM core.satelite WHERE nome IS NULL;
SELECT COUNT(*) FROM core.satelite WHERE agencia IS NULL;
SELECT COUNT(*) FROM core.satelite WHERE data_lancamento IS NULL; 
SELECT COUNT(*) FROM core.satelite WHERE data_lancamento > CURRENT_DATE;
--Verificar se existem registros duplicados, contando quantos valores únicos existem na coluna id_satelite.
SELECT COUNT(DISTINCT id_satelite) FROM core.satelite;
-- listar todos os registros da tabela core.satelite	
select * from core.satelite;

