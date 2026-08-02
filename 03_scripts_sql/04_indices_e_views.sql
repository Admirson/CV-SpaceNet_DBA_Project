/* ============================================================
   4. CRIAR ÍNDICES
   ============================================================ */
CREATE INDEX idx_evento_data ON pesca.evento_pesca_ilegal(data_evento);
CREATE INDEX idx_embarcacao_nome ON pesca.embarcacao(nome);
CREATE INDEX idx_bruma_data ON meteo.observacao_bruma(data_observacao);
CREATE INDEX idx_imagem_data ON geo.imagem(data_captura);

/* ============================================================
   5. CRIAR VIEWS
   ============================================================ */

/* ------------------------------------------------------------
   View: resumo de pesca ilegal
   ------------------------------------------------------------ */
CREATE VIEW pesca.vw_resumo_pesca AS
SELECT 
    e.id_evento,
    em.nome AS embarcacao,
    s.nome AS satelite,
    e.data_evento,
    e.latitude,
    e.longitude
FROM pesca.evento_pesca_ilegal e
JOIN pesca.embarcacao em ON e.id_embarcacao = em.id_embarcacao
JOIN core.satelite s ON e.id_satelite = s.id_satelite;

/* ------------------------------------------------------------
   View: observações da Bruma Seca
   ------------------------------------------------------------ */
CREATE VIEW meteo.vw_bruma AS
SELECT 
    o.id_observacao,
    s.nome AS satelite,
    o.data_observacao,
    o.densidade_poeria,
    o.visibilidade_km
FROM meteo.observacao_bruma o
JOIN core.satelite s ON o.id_satelite = s.id_satelite;
