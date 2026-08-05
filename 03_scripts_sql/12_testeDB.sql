-- 1. Criação de base de dados para teste
CREATE DATABASE TesteDB;
\c TesteDB   -- Conectar à base de dados TesteDB

-- 2. Criação de tabela para teste
CREATE TABLE FORMANDO_Teste (
    id_formando SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- 3. Inserção de dados de teste
INSERT INTO FORMANDO_Teste (nome, data_nascimento, telefone, email) VALUES
    ('Maria Lopes','2000-05-10','912345678','maria@email.com'),
    ('Pedro Santos','1999-03-15','923456789','pedro@email.com'),
    ('Ana Costa','2001-07-20','934567890','ana@email.com'),
    ('Luis Pinto','1998-11-02','945678901','luis@email.com'),
    ('Carla Dias','2002-01-25','956789012','carla@email.com');

-- 4. Consulta de teste
SELECT * FROM FORMANDO_Teste;

-- 5. Criação de utilizador inativo de teste
CREATE ROLE utilizador_inativo LOGIN PASSWORD 'SenhaForte123';

-- 6. Conceder permissões iniciais (exemplo: acesso à base de dados TesteDB)
GRANT CONNECT ON DATABASE TesteDB TO utilizador_inativo;

-- 7. Revogar todos os privilégios do utilizador
REVOKE ALL PRIVILEGES ON DATABASE TesteDB FROM utilizador_inativo;

-- 8. Remover privilégios de superusuário
ALTER ROLE utilizador_inativo NOSUPERUSER;

-- 9. Bloquear login sem apagar o utilizador
ALTER ROLE utilizador_inativo NOLOGIN;

-- 10. Eliminar utilizador definitivamente
DROP ROLE utilizador_inativo;
