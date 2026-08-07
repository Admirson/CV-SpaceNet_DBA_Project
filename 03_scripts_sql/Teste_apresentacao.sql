-- Verificar roles e permissões
SELECT rolname, rolsuper, rolcreaterole, rolcreatedb, rolcanlogin
FROM pg_roles
WHERE rolname IN ('postgres', 'dba', 'programador', 'gestor', 'analista', 'auditor',
'aplicacao', 'usr_dba', 'usr_prog', 'usr_gestor', 'usr_analista','usr_auditor', 'usr_app' );

-- Verificar membros de cada role
SELECT roleid::regrole, member::regrole
FROM pg_auth_members WHERE roleid::regrole
IN ('dba', 'programador', 'gestor', 'analista', 'auditor',
'aplicacao', 'usr_dba', 'usr_prog', 'usr_gestor',
'usr_analista','usr_auditor', 'usr_app' );

-- Verificar privilégios em tabelas
SELECT grantee, privilege_type, table_schema, table_name
FROM information_schema.role_table_grants;
WHERE grantee in ('dba', 'programador', 'gestor', 'analista', 'auditor',
'aplicacao', 'usr_dba', 'usr_prog', 'usr_gestor',
'usr_analista','usr_auditor', 'usr_app' );
