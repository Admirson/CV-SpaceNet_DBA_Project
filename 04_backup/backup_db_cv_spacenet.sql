--
-- PostgreSQL database dump
--

\restrict UeuVBb6YohUvhASvdN3DMTbd3r2EFaTkLkkootfCPAxgfntjJx9Dx5Al5SdkNDd

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-08-04 20:50:13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 24577)
-- Name: core; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA core;


ALTER SCHEMA core OWNER TO postgres;

--
-- TOC entry 9 (class 2615 OID 24580)
-- Name: geo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA geo;


ALTER SCHEMA geo OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 24579)
-- Name: meteo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA meteo;


ALTER SCHEMA meteo OWNER TO postgres;

--
-- TOC entry 7 (class 2615 OID 24578)
-- Name: pesca; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pesca;


ALTER SCHEMA pesca OWNER TO postgres;

--
-- TOC entry 10 (class 2615 OID 32771)
-- Name: testes; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA testes;


ALTER SCHEMA testes OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 225 (class 1259 OID 24582)
-- Name: satelite; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.satelite (
    id_satelite integer NOT NULL,
    nome character varying(100) NOT NULL,
    agencia character varying(100) NOT NULL,
    data_lancamento date,
    estado character varying(20) DEFAULT 'ativo'::character varying,
    CONSTRAINT satelite_estado_check CHECK (((estado)::text = ANY ((ARRAY['ativo'::character varying, 'inativo'::character varying, 'manutencao'::character varying])::text[])))
);


ALTER TABLE core.satelite OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24581)
-- Name: satelite_id_satelite_seq; Type: SEQUENCE; Schema: core; Owner: postgres
--

CREATE SEQUENCE core.satelite_id_satelite_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core.satelite_id_satelite_seq OWNER TO postgres;

--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 224
-- Name: satelite_id_satelite_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: postgres
--

ALTER SEQUENCE core.satelite_id_satelite_seq OWNED BY core.satelite.id_satelite;


--
-- TOC entry 237 (class 1259 OID 32775)
-- Name: satelite_tmp; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.satelite_tmp (
    id_satelite integer,
    nome character varying(100),
    agencia character varying(100),
    data_lancamento date,
    estado character varying(20)
);


ALTER TABLE core.satelite_tmp OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 24647)
-- Name: imagem; Type: TABLE; Schema: geo; Owner: postgres
--

CREATE TABLE geo.imagem (
    id_imagem integer NOT NULL,
    id_satelite integer NOT NULL,
    data_captura timestamp without time zone NOT NULL,
    resolucao character varying(50),
    caminho_ficheiro character varying(255) NOT NULL
);


ALTER TABLE geo.imagem OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 24646)
-- Name: imagem_id_imagem_seq; Type: SEQUENCE; Schema: geo; Owner: postgres
--

CREATE SEQUENCE geo.imagem_id_imagem_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE geo.imagem_id_imagem_seq OWNER TO postgres;

--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 232
-- Name: imagem_id_imagem_seq; Type: SEQUENCE OWNED BY; Schema: geo; Owner: postgres
--

ALTER SEQUENCE geo.imagem_id_imagem_seq OWNED BY geo.imagem.id_imagem;


--
-- TOC entry 231 (class 1259 OID 24631)
-- Name: observacao_bruma; Type: TABLE; Schema: meteo; Owner: postgres
--

CREATE TABLE meteo.observacao_bruma (
    id_observacao integer NOT NULL,
    id_satelite integer NOT NULL,
    data_observacao timestamp without time zone NOT NULL,
    densidade_poeria numeric(6,2),
    visibilidade_km numeric(6,2),
    temperatura numeric(4,1),
    humidade numeric(4,1),
    CONSTRAINT observacao_bruma_densidade_poeria_check CHECK ((densidade_poeria >= (0)::numeric))
);


ALTER TABLE meteo.observacao_bruma OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 24630)
-- Name: observacao_bruma_id_observacao_seq; Type: SEQUENCE; Schema: meteo; Owner: postgres
--

CREATE SEQUENCE meteo.observacao_bruma_id_observacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE meteo.observacao_bruma_id_observacao_seq OWNER TO postgres;

--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 230
-- Name: observacao_bruma_id_observacao_seq; Type: SEQUENCE OWNED BY; Schema: meteo; Owner: postgres
--

ALTER SEQUENCE meteo.observacao_bruma_id_observacao_seq OWNED BY meteo.observacao_bruma.id_observacao;


--
-- TOC entry 235 (class 1259 OID 24673)
-- Name: vw_bruma; Type: VIEW; Schema: meteo; Owner: postgres
--

CREATE VIEW meteo.vw_bruma AS
 SELECT o.id_observacao,
    s.nome AS satelite,
    o.data_observacao,
    o.densidade_poeria,
    o.visibilidade_km
   FROM (meteo.observacao_bruma o
     JOIN core.satelite s ON ((o.id_satelite = s.id_satelite)));


ALTER VIEW meteo.vw_bruma OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24594)
-- Name: embarcacao; Type: TABLE; Schema: pesca; Owner: postgres
--

CREATE TABLE pesca.embarcacao (
    id_embarcacao integer NOT NULL,
    nome character varying(120) NOT NULL,
    pais_bandeira character varying(50) NOT NULL,
    tipo character varying(50),
    imo character varying(20)
);


ALTER TABLE pesca.embarcacao OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24593)
-- Name: embarcacao_id_embarcacao_seq; Type: SEQUENCE; Schema: pesca; Owner: postgres
--

CREATE SEQUENCE pesca.embarcacao_id_embarcacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pesca.embarcacao_id_embarcacao_seq OWNER TO postgres;

--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 226
-- Name: embarcacao_id_embarcacao_seq; Type: SEQUENCE OWNED BY; Schema: pesca; Owner: postgres
--

ALTER SEQUENCE pesca.embarcacao_id_embarcacao_seq OWNED BY pesca.embarcacao.id_embarcacao;


--
-- TOC entry 229 (class 1259 OID 24606)
-- Name: evento_pesca_ilegal; Type: TABLE; Schema: pesca; Owner: postgres
--

CREATE TABLE pesca.evento_pesca_ilegal (
    id_evento integer NOT NULL,
    id_embarcacao integer NOT NULL,
    id_satelite integer NOT NULL,
    data_evento timestamp without time zone NOT NULL,
    latitude numeric(10,6) NOT NULL,
    longitude numeric(10,6) NOT NULL,
    descricao text
);


ALTER TABLE pesca.evento_pesca_ilegal OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24605)
-- Name: evento_pesca_ilegal_id_evento_seq; Type: SEQUENCE; Schema: pesca; Owner: postgres
--

CREATE SEQUENCE pesca.evento_pesca_ilegal_id_evento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pesca.evento_pesca_ilegal_id_evento_seq OWNER TO postgres;

--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 228
-- Name: evento_pesca_ilegal_id_evento_seq; Type: SEQUENCE OWNED BY; Schema: pesca; Owner: postgres
--

ALTER SEQUENCE pesca.evento_pesca_ilegal_id_evento_seq OWNED BY pesca.evento_pesca_ilegal.id_evento;


--
-- TOC entry 234 (class 1259 OID 24668)
-- Name: vw_resumo_pesca; Type: VIEW; Schema: pesca; Owner: postgres
--

CREATE VIEW pesca.vw_resumo_pesca AS
 SELECT e.id_evento,
    em.nome AS embarcacao,
    s.nome AS satelite,
    e.data_evento,
    e.latitude,
    e.longitude
   FROM ((pesca.evento_pesca_ilegal e
     JOIN pesca.embarcacao em ON ((e.id_embarcacao = em.id_embarcacao)))
     JOIN core.satelite s ON ((e.id_satelite = s.id_satelite)));


ALTER VIEW pesca.vw_resumo_pesca OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 32768)
-- Name: satelite_check; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satelite_check (
    id_satelite integer,
    nome character varying(100),
    agencia character varying(100),
    data_lancamento date,
    estado character varying(20)
);


ALTER TABLE public.satelite_check OWNER TO postgres;

--
-- TOC entry 4703 (class 2604 OID 24585)
-- Name: satelite id_satelite; Type: DEFAULT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.satelite ALTER COLUMN id_satelite SET DEFAULT nextval('core.satelite_id_satelite_seq'::regclass);


--
-- TOC entry 4708 (class 2604 OID 24650)
-- Name: imagem id_imagem; Type: DEFAULT; Schema: geo; Owner: postgres
--

ALTER TABLE ONLY geo.imagem ALTER COLUMN id_imagem SET DEFAULT nextval('geo.imagem_id_imagem_seq'::regclass);


--
-- TOC entry 4707 (class 2604 OID 24634)
-- Name: observacao_bruma id_observacao; Type: DEFAULT; Schema: meteo; Owner: postgres
--

ALTER TABLE ONLY meteo.observacao_bruma ALTER COLUMN id_observacao SET DEFAULT nextval('meteo.observacao_bruma_id_observacao_seq'::regclass);


--
-- TOC entry 4705 (class 2604 OID 24597)
-- Name: embarcacao id_embarcacao; Type: DEFAULT; Schema: pesca; Owner: postgres
--

ALTER TABLE ONLY pesca.embarcacao ALTER COLUMN id_embarcacao SET DEFAULT nextval('pesca.embarcacao_id_embarcacao_seq'::regclass);


--
-- TOC entry 4706 (class 2604 OID 24609)
-- Name: evento_pesca_ilegal id_evento; Type: DEFAULT; Schema: pesca; Owner: postgres
--

ALTER TABLE ONLY pesca.evento_pesca_ilegal ALTER COLUMN id_evento SET DEFAULT nextval('pesca.evento_pesca_ilegal_id_evento_seq'::regclass);


--
-- TOC entry 4883 (class 0 OID 24582)
-- Dependencies: 225
-- Data for Name: satelite; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.satelite (id_satelite, nome, agencia, data_lancamento, estado) FROM stdin;
1	Sentinel-1A	ESA	2014-04-03	ativo
2	Landsat-8	NASA	2013-02-11	ativo
3	Gaofen-3	CNSA	2016-08-10	manutencao
4	Sentinel-2B	ESA	2017-03-07	ativo
5	Aqua	NASA	2002-05-04	inativo
\.


--
-- TOC entry 4893 (class 0 OID 32775)
-- Dependencies: 237
-- Data for Name: satelite_tmp; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.satelite_tmp (id_satelite, nome, agencia, data_lancamento, estado) FROM stdin;
1	Sentinel-1A	ESA	2014-04-03	ativo
2	Landsat-8	NASA	2013-02-11	ativo
3	Gaofen-3	CNSA	2016-08-10	manutencao
4	Sentinel-2B	ESA	2017-03-07	ativo
5	Aqua	NASA	2002-05-04	inativo
\.


--
-- TOC entry 4891 (class 0 OID 24647)
-- Dependencies: 233
-- Data for Name: imagem; Type: TABLE DATA; Schema: geo; Owner: postgres
--

COPY geo.imagem (id_imagem, id_satelite, data_captura, resolucao, caminho_ficheiro) FROM stdin;
1	1	2026-07-01 06:00:00	10m	/imagens/sentinel1a_20260701.png
2	2	2026-07-02 06:30:00	15m	/imagens/landsat8_20260702.png
3	3	2026-07-03 07:00:00	5m	/imagens/gaofen3_20260703.png
4	4	2026-07-04 07:30:00	10m	/imagens/sentinel2b_20260704.png
5	5	2026-07-05 08:00:00	20m	/imagens/aqua_20260705.png
\.


--
-- TOC entry 4889 (class 0 OID 24631)
-- Dependencies: 231
-- Data for Name: observacao_bruma; Type: TABLE DATA; Schema: meteo; Owner: postgres
--

COPY meteo.observacao_bruma (id_observacao, id_satelite, data_observacao, densidade_poeria, visibilidade_km, temperatura, humidade) FROM stdin;
1	1	2026-07-01 08:00:00	120.50	5.20	28.5	65.0
2	2	2026-07-02 09:30:00	98.20	7.00	27.8	60.0
3	3	2026-07-03 10:15:00	150.00	4.50	29.1	70.0
4	4	2026-07-04 11:00:00	80.75	8.30	26.9	55.0
5	5	2026-07-05 12:45:00	110.40	6.10	27.3	62.0
\.


--
-- TOC entry 4885 (class 0 OID 24594)
-- Dependencies: 227
-- Data for Name: embarcacao; Type: TABLE DATA; Schema: pesca; Owner: postgres
--

COPY pesca.embarcacao (id_embarcacao, nome, pais_bandeira, tipo, imo) FROM stdin;
1	Mar Azul	Cabo Verde	Pesqueiro	IMO1234567
2	Sol Nascente	Brasil	Industrial	IMO7654321
3	Oceano Livre	Portugal	Atuneiro	IMO9988776
4	Ventania	Espanha	Arrastão	IMO1122334
5	Estrela do Mar	Cabo Verde	Pesqueiro	IMO5566778
\.


--
-- TOC entry 4887 (class 0 OID 24606)
-- Dependencies: 229
-- Data for Name: evento_pesca_ilegal; Type: TABLE DATA; Schema: pesca; Owner: postgres
--

COPY pesca.evento_pesca_ilegal (id_evento, id_embarcacao, id_satelite, data_evento, latitude, longitude, descricao) FROM stdin;
1	1	1	2026-07-01 10:30:00	14.923456	-23.512345	Atividade suspeita detectada.
2	2	3	2026-07-02 14:10:00	15.123456	-23.612345	Rede de pesca não autorizada.
3	3	2	2026-07-03 09:45:00	14.823456	-23.432345	Embarcação fora da zona permitida.
4	4	5	2026-07-04 16:20:00	15.223456	-23.712345	Movimento irregular detectado.
5	5	4	2026-07-05 11:55:00	14.723456	-23.512345	Possível pesca ilegal.
\.


--
-- TOC entry 4892 (class 0 OID 32768)
-- Dependencies: 236
-- Data for Name: satelite_check; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.satelite_check (id_satelite, nome, agencia, data_lancamento, estado) FROM stdin;
1	Sentinel-1A	ESA	2014-04-03	ativo
2	Landsat-8	NASA	2013-02-11	ativo
3	Gaofen-3	CNSA	2016-08-10	manutencao
4	Sentinel-2B	ESA	2017-03-07	ativo
5	Aqua	NASA	2002-05-04	inativo
\.


--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 224
-- Name: satelite_id_satelite_seq; Type: SEQUENCE SET; Schema: core; Owner: postgres
--

SELECT pg_catalog.setval('core.satelite_id_satelite_seq', 5, true);


--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 232
-- Name: imagem_id_imagem_seq; Type: SEQUENCE SET; Schema: geo; Owner: postgres
--

SELECT pg_catalog.setval('geo.imagem_id_imagem_seq', 5, true);


--
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 230
-- Name: observacao_bruma_id_observacao_seq; Type: SEQUENCE SET; Schema: meteo; Owner: postgres
--

SELECT pg_catalog.setval('meteo.observacao_bruma_id_observacao_seq', 5, true);


--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 226
-- Name: embarcacao_id_embarcacao_seq; Type: SEQUENCE SET; Schema: pesca; Owner: postgres
--

SELECT pg_catalog.setval('pesca.embarcacao_id_embarcacao_seq', 5, true);


--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 228
-- Name: evento_pesca_ilegal_id_evento_seq; Type: SEQUENCE SET; Schema: pesca; Owner: postgres
--

SELECT pg_catalog.setval('pesca.evento_pesca_ilegal_id_evento_seq', 5, true);


--
-- TOC entry 4712 (class 2606 OID 24592)
-- Name: satelite satelite_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.satelite
    ADD CONSTRAINT satelite_pkey PRIMARY KEY (id_satelite);


--
-- TOC entry 4726 (class 2606 OID 24658)
-- Name: imagem imagem_caminho_ficheiro_key; Type: CONSTRAINT; Schema: geo; Owner: postgres
--

ALTER TABLE ONLY geo.imagem
    ADD CONSTRAINT imagem_caminho_ficheiro_key UNIQUE (caminho_ficheiro);


--
-- TOC entry 4728 (class 2606 OID 24656)
-- Name: imagem imagem_pkey; Type: CONSTRAINT; Schema: geo; Owner: postgres
--

ALTER TABLE ONLY geo.imagem
    ADD CONSTRAINT imagem_pkey PRIMARY KEY (id_imagem);


--
-- TOC entry 4723 (class 2606 OID 24640)
-- Name: observacao_bruma observacao_bruma_pkey; Type: CONSTRAINT; Schema: meteo; Owner: postgres
--

ALTER TABLE ONLY meteo.observacao_bruma
    ADD CONSTRAINT observacao_bruma_pkey PRIMARY KEY (id_observacao);


--
-- TOC entry 4714 (class 2606 OID 24604)
-- Name: embarcacao embarcacao_imo_key; Type: CONSTRAINT; Schema: pesca; Owner: postgres
--

ALTER TABLE ONLY pesca.embarcacao
    ADD CONSTRAINT embarcacao_imo_key UNIQUE (imo);


--
-- TOC entry 4716 (class 2606 OID 24602)
-- Name: embarcacao embarcacao_pkey; Type: CONSTRAINT; Schema: pesca; Owner: postgres
--

ALTER TABLE ONLY pesca.embarcacao
    ADD CONSTRAINT embarcacao_pkey PRIMARY KEY (id_embarcacao);


--
-- TOC entry 4719 (class 2606 OID 24619)
-- Name: evento_pesca_ilegal evento_pesca_ilegal_pkey; Type: CONSTRAINT; Schema: pesca; Owner: postgres
--

ALTER TABLE ONLY pesca.evento_pesca_ilegal
    ADD CONSTRAINT evento_pesca_ilegal_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 4724 (class 1259 OID 24667)
-- Name: idx_imagem_data; Type: INDEX; Schema: geo; Owner: postgres
--

CREATE INDEX idx_imagem_data ON geo.imagem USING btree (data_captura);


--
-- TOC entry 4721 (class 1259 OID 24666)
-- Name: idx_bruma_data; Type: INDEX; Schema: meteo; Owner: postgres
--

CREATE INDEX idx_bruma_data ON meteo.observacao_bruma USING btree (data_observacao);


--
-- TOC entry 4717 (class 1259 OID 24665)
-- Name: idx_embarcacao_nome; Type: INDEX; Schema: pesca; Owner: postgres
--

CREATE INDEX idx_embarcacao_nome ON pesca.embarcacao USING btree (nome);


--
-- TOC entry 4720 (class 1259 OID 24664)
-- Name: idx_evento_data; Type: INDEX; Schema: pesca; Owner: postgres
--

CREATE INDEX idx_evento_data ON pesca.evento_pesca_ilegal USING btree (data_evento);


--
-- TOC entry 4732 (class 2606 OID 24659)
-- Name: imagem imagem_id_satelite_fkey; Type: FK CONSTRAINT; Schema: geo; Owner: postgres
--

ALTER TABLE ONLY geo.imagem
    ADD CONSTRAINT imagem_id_satelite_fkey FOREIGN KEY (id_satelite) REFERENCES core.satelite(id_satelite);


--
-- TOC entry 4731 (class 2606 OID 24641)
-- Name: observacao_bruma observacao_bruma_id_satelite_fkey; Type: FK CONSTRAINT; Schema: meteo; Owner: postgres
--

ALTER TABLE ONLY meteo.observacao_bruma
    ADD CONSTRAINT observacao_bruma_id_satelite_fkey FOREIGN KEY (id_satelite) REFERENCES core.satelite(id_satelite);


--
-- TOC entry 4729 (class 2606 OID 24620)
-- Name: evento_pesca_ilegal evento_pesca_ilegal_id_embarcacao_fkey; Type: FK CONSTRAINT; Schema: pesca; Owner: postgres
--

ALTER TABLE ONLY pesca.evento_pesca_ilegal
    ADD CONSTRAINT evento_pesca_ilegal_id_embarcacao_fkey FOREIGN KEY (id_embarcacao) REFERENCES pesca.embarcacao(id_embarcacao);


--
-- TOC entry 4730 (class 2606 OID 24625)
-- Name: evento_pesca_ilegal evento_pesca_ilegal_id_satelite_fkey; Type: FK CONSTRAINT; Schema: pesca; Owner: postgres
--

ALTER TABLE ONLY pesca.evento_pesca_ilegal
    ADD CONSTRAINT evento_pesca_ilegal_id_satelite_fkey FOREIGN KEY (id_satelite) REFERENCES core.satelite(id_satelite);


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA core; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA core TO programador;


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 9
-- Name: SCHEMA geo; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA geo TO programador;


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA meteo; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA meteo TO programador;


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA pesca; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA pesca TO programador;


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE satelite; Type: ACL; Schema: core; Owner: postgres
--

GRANT ALL ON TABLE core.satelite TO dba;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE core.satelite TO programador;
GRANT SELECT ON TABLE core.satelite TO gestor;
GRANT SELECT ON TABLE core.satelite TO analista;
GRANT SELECT ON TABLE core.satelite TO auditor;
GRANT SELECT ON TABLE core.satelite TO aplicacao;


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE imagem; Type: ACL; Schema: geo; Owner: postgres
--

GRANT ALL ON TABLE geo.imagem TO dba;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE geo.imagem TO programador;
GRANT SELECT ON TABLE geo.imagem TO gestor;
GRANT SELECT ON TABLE geo.imagem TO analista;
GRANT SELECT ON TABLE geo.imagem TO auditor;


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE observacao_bruma; Type: ACL; Schema: meteo; Owner: postgres
--

GRANT ALL ON TABLE meteo.observacao_bruma TO dba;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE meteo.observacao_bruma TO programador;
GRANT SELECT ON TABLE meteo.observacao_bruma TO gestor;
GRANT SELECT ON TABLE meteo.observacao_bruma TO analista;
GRANT SELECT ON TABLE meteo.observacao_bruma TO auditor;


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE vw_bruma; Type: ACL; Schema: meteo; Owner: postgres
--

GRANT ALL ON TABLE meteo.vw_bruma TO dba;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE meteo.vw_bruma TO programador;
GRANT SELECT ON TABLE meteo.vw_bruma TO gestor;
GRANT SELECT ON TABLE meteo.vw_bruma TO analista;
GRANT SELECT ON TABLE meteo.vw_bruma TO auditor;


--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE embarcacao; Type: ACL; Schema: pesca; Owner: postgres
--

GRANT ALL ON TABLE pesca.embarcacao TO dba;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE pesca.embarcacao TO programador;
GRANT SELECT ON TABLE pesca.embarcacao TO gestor;
GRANT SELECT ON TABLE pesca.embarcacao TO analista;
GRANT SELECT ON TABLE pesca.embarcacao TO auditor;


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE evento_pesca_ilegal; Type: ACL; Schema: pesca; Owner: postgres
--

GRANT ALL ON TABLE pesca.evento_pesca_ilegal TO dba;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE pesca.evento_pesca_ilegal TO programador;
GRANT SELECT ON TABLE pesca.evento_pesca_ilegal TO gestor;
GRANT SELECT ON TABLE pesca.evento_pesca_ilegal TO analista;
GRANT SELECT ON TABLE pesca.evento_pesca_ilegal TO auditor;
GRANT SELECT,INSERT ON TABLE pesca.evento_pesca_ilegal TO aplicacao;


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE vw_resumo_pesca; Type: ACL; Schema: pesca; Owner: postgres
--

GRANT ALL ON TABLE pesca.vw_resumo_pesca TO dba;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE pesca.vw_resumo_pesca TO programador;
GRANT SELECT ON TABLE pesca.vw_resumo_pesca TO gestor;
GRANT SELECT ON TABLE pesca.vw_resumo_pesca TO analista;
GRANT SELECT ON TABLE pesca.vw_resumo_pesca TO auditor;


-- Completed on 2026-08-04 20:50:13

--
-- PostgreSQL database dump complete
--

\unrestrict UeuVBb6YohUvhASvdN3DMTbd3r2EFaTkLkkootfCPAxgfntjJx9Dx5Al5SdkNDd

