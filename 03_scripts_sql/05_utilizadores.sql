
/* ============================================================
   1. CRIAR PERFIS (ROLES) RBAC – SEM LOGIN
   ============================================================ */

CREATE ROLE dba NOLOGIN;
CREATE ROLE programador NOLOGIN;
CREATE ROLE gestor NOLOGIN;
CREATE ROLE analista NOLOGIN;
CREATE ROLE auditor NOLOGIN;
CREATE ROLE aplicacao NOLOGIN;

/* ============================================================
   2. CRIAR UTILIZADORES E ATRIBUIR PERFIS
   ============================================================ */

-- UTILIZADORES DO SISTEMA
CREATE USER usr_dba      WITH PASSWORD 'Dba@2026';
CREATE USER usr_prog     WITH PASSWORD 'Prog@2026';
CREATE USER usr_gestor   WITH PASSWORD 'Gestor@2026';
CREATE USER usr_analista WITH PASSWORD 'Analista@2026';
CREATE USER usr_auditor  WITH PASSWORD 'Auditor@2026';
CREATE USER usr_app      WITH PASSWORD 'App@2026';

-- ATRIBUIR ROLES AOS UTILIZADORES
GRANT dba       TO usr_dba;
GRANT programador TO usr_prog;
GRANT gestor      TO usr_gestor;
GRANT analista    TO usr_analista;
GRANT auditor     TO usr_auditor;
GRANT aplicacao   TO usr_app;
