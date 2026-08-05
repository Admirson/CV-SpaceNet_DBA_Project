/* ============================================================
	PERMISSÕES POR PERFIL - PRINCÍPIO DO MENOR PRIVILÉGIO
   ============================================================ */
/* ============================================================
   USAGE PARA TODOS OS UTILIZADORES EM TODOS OS SCHEMAS
   ============================================================ */

-- Schema core
GRANT USAGE ON SCHEMA core TO dba, programador, gestor, analista, auditor, aplicacao;

-- Schema pesca
GRANT USAGE ON SCHEMA pesca TO dba, programador, gestor, analista, auditor, aplicacao;

-- Schema meteo
GRANT USAGE ON SCHEMA meteo TO dba, programador, gestor, analista, auditor, aplicacao;

-- Schema geo
GRANT USAGE ON SCHEMA geo TO dba, programador, gestor, analista, auditor, aplicacao;

/* ------------------------------------------------------------
	PERFIL DBA – Administração total
   ------------------------------------------------------------ */
GRANT ALL PRIVILEGES ON DATABASE cv_spacenet TO dba;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA core TO dba;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA pesca TO dba;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA meteo TO dba;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA geo TO dba;

/* ------------------------------------------------------------
   PERFIL PROGRAMADOR – Criar e alterar objetos
   ------------------------------------------------------------ */
GRANT CREATE, USAGE ON SCHEMA core TO programador;
GRANT CREATE, USAGE ON SCHEMA pesca TO programador;
GRANT CREATE, USAGE ON SCHEMA meteo TO programador;
GRANT CREATE, USAGE ON SCHEMA geo TO programador;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA core TO programador;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pesca TO programador;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA meteo TO programador;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA geo TO programador;

/* ------------------------------------------------------------
   PERFIL GESTOR – Apenas consulta de indicadores
   ------------------------------------------------------------ */
GRANT SELECT ON ALL TABLES IN SCHEMA core TO gestor;
GRANT SELECT ON ALL TABLES IN SCHEMA pesca TO gestor;
GRANT SELECT ON ALL TABLES IN SCHEMA meteo TO gestor;
GRANT SELECT ON ALL TABLES IN SCHEMA geo TO gestor;

GRANT SELECT ON pesca.vw_resumo_pesca TO gestor;
GRANT SELECT ON meteo.vw_bruma TO gestor;

/* ------------------------------------------------------------
   PERFIL ANALISTA – Consultas e relatórios avançados
   ------------------------------------------------------------ */
GRANT SELECT ON ALL TABLES IN SCHEMA core TO analista;
GRANT SELECT ON ALL TABLES IN SCHEMA pesca TO analista;
GRANT SELECT ON ALL TABLES IN SCHEMA meteo TO analista;
GRANT SELECT ON ALL TABLES IN SCHEMA geo TO analista;

GRANT TEMPORARY ON DATABASE cv_spacenet TO analista;

/* ------------------------------------------------------------
   PERFIL AUDITOR – Apenas leitura e auditoria
   ------------------------------------------------------------ */
GRANT SELECT ON ALL TABLES IN SCHEMA core TO auditor;
GRANT SELECT ON ALL TABLES IN SCHEMA pesca TO auditor;
GRANT SELECT ON ALL TABLES IN SCHEMA meteo TO auditor;
GRANT SELECT ON ALL TABLES IN SCHEMA geo TO auditor;

REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA core FROM auditor;
REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pesca FROM auditor;
REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA meteo FROM auditor;
REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA geo FROM auditor;

/* ------------------------------------------------------------
   PERFIL APLICAÇÃO – Acesso mínimo para sistemas externos
   ------------------------------------------------------------ */
GRANT SELECT, INSERT ON pesca.evento_pesca_ilegal TO aplicacao;
GRANT SELECT ON core.satelite TO aplicacao;

REVOKE UPDATE, DELETE ON ALL TABLES IN SCHEMA core FROM aplicacao;
REVOKE UPDATE, DELETE ON ALL TABLES IN SCHEMA pesca FROM aplicacao;
REVOKE UPDATE, DELETE ON ALL TABLES IN SCHEMA meteo FROM aplicacao;
REVOKE UPDATE, DELETE ON ALL TABLES IN SCHEMA geo FROM aplicacao;

