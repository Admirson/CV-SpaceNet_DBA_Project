-- Validação do Ambiente PostgreSQL
SELECT version() AS VersaoPostgreSQL;

SELECT inet_server_addr() AS EnderecoServidor;

SELECT CURRENT_TIMESTAMP AS DataHoraAtual;

SELECT current_database() As BaseDeDadosAtual;

SELECT current_user as UsuarioAtual;
