/* ============================================================
   INSERIR 5 REGISTOS EM CADA TABELA
   ============================================================ */

/* ------------------------------------------------------------
   Inserir satélites
   ------------------------------------------------------------ */
INSERT INTO core.satelite (nome, agencia, data_lancamento, estado) VALUES
('Sentinel-1A', 'ESA', '2014-04-03', 'ativo'),
('Landsat-8', 'NASA', '2013-02-11', 'ativo'),
('Gaofen-3', 'CNSA', '2016-08-10', 'manutencao'),
('Sentinel-2B', 'ESA', '2017-03-07', 'ativo'),
('Aqua', 'NASA', '2002-05-04', 'inativo');

/* ------------------------------------------------------------
   Inserir embarcações
   ------------------------------------------------------------ */
INSERT INTO pesca.embarcacao (nome, pais_bandeira, tipo, imo) VALUES
('Mar Azul', 'Cabo Verde', 'Pesqueiro', 'IMO1234567'),
('Sol Nascente', 'Brasil', 'Industrial', 'IMO7654321'),
('Oceano Livre', 'Portugal', 'Atuneiro', 'IMO9988776'),
('Ventania', 'Espanha', 'Arrastão', 'IMO1122334'),
('Estrela do Mar', 'Cabo Verde', 'Pesqueiro', 'IMO5566778');

/* ------------------------------------------------------------
   Inserir eventos de pesca ilegal
   ------------------------------------------------------------ */
INSERT INTO pesca.evento_pesca_ilegal 
(id_embarcacao, id_satelite, data_evento, latitude, longitude, descricao)
VALUES
(1, 1, '2026-07-01 10:30', 14.923456, -23.512345, 'Atividade suspeita detectada.'),
(2, 3, '2026-07-02 14:10', 15.123456, -23.612345, 'Rede de pesca não autorizada.'),
(3, 2, '2026-07-03 09:45', 14.823456, -23.432345, 'Embarcação fora da zona permitida.'),
(4, 5, '2026-07-04 16:20', 15.223456, -23.712345, 'Movimento irregular detectado.'),
(5, 4, '2026-07-05 11:55', 14.723456, -23.512345, 'Possível pesca ilegal.');

/* ------------------------------------------------------------
   Inserir observações da Bruma Seca
   ------------------------------------------------------------ */
INSERT INTO meteo.observacao_bruma
(id_satelite, data_observacao, densidade_poeria, visibilidade_km, temperatura, humidade)
VALUES
(1, '2026-07-01 08:00', 120.50, 5.2, 28.5, 65.0),
(2, '2026-07-02 09:30', 98.20, 7.0, 27.8, 60.0),
(3, '2026-07-03 10:15', 150.00, 4.5, 29.1, 70.0),
(4, '2026-07-04 11:00', 80.75, 8.3, 26.9, 55.0),
(5, '2026-07-05 12:45', 110.40, 6.1, 27.3, 62.0);

/* ------------------------------------------------------------
   Inserir imagens geoespaciais
   ------------------------------------------------------------ */
INSERT INTO geo.imagem
(id_satelite, data_captura, resolucao, caminho_ficheiro)
VALUES
(1, '2026-07-01 06:00', '10m', '/imagens/sentinel1a_20260701.png'),
(2, '2026-07-02 06:30', '15m', '/imagens/landsat8_20260702.png'),
(3, '2026-07-03 07:00', '5m', '/imagens/gaofen3_20260703.png'),
(4, '2026-07-04 07:30', '10m', '/imagens/sentinel2b_20260704.png'),
(5, '2026-07-05 08:00', '20m', '/imagens/aqua_20260705.png');