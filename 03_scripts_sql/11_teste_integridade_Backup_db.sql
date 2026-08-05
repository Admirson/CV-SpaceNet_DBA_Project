-- script para verificar a integridade do backup do banco de dados
SELECT 
    'Tabelas' as tipo,
    COUNT(*) as total
FROM pg_tables 
WHERE schemaname IN ('core', 'geo', 'meteo', 'pesca')
UNION ALL
SELECT 
    'Views',
    COUNT(*) 
FROM pg_views 
WHERE schemaname IN ('core', 'geo', 'meteo', 'pesca')
UNION ALL
SELECT 
    'Seq. Ajustadas',
    COUNT(*) 
FROM (
    SELECT 'core.satelite_id_satelite_seq' as seq WHERE 
    (SELECT last_value FROM core.satelite_id_satelite_seq) >= (SELECT MAX(id_satelite) FROM core.satelite)
    UNION ALL
    SELECT 'geo.imagem_id_imagem_seq' WHERE 
    (SELECT last_value FROM geo.imagem_id_imagem_seq) >= (SELECT MAX(id_imagem) FROM geo.imagem)
) t
UNION ALL
SELECT 
    'Registros totais',
    (SELECT COUNT(*) FROM core.satelite) +
    (SELECT COUNT(*) FROM geo.imagem) +
    (SELECT COUNT(*) FROM meteo.observacao_bruma) +
    (SELECT COUNT(*) FROM pesca.embarcacao) +
    (SELECT COUNT(*) FROM pesca.evento_pesca_ilegal);