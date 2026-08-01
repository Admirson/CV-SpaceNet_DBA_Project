--Criação de base de dados para teste
CREATE DATABASE TesteDB;
Select current_database();

--Criação de tabela para teste
CREATE TABLE FORMANDO_Teste (
    id_formando SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);
-- Sexecutando teste de inserção na tabela de testes
INSERT INTO FORMANDO_Teste (nome, data_nascimento, telefone, email) VALUES
    ('Maria Lopes','2000-05-10','912345678','maria@email.com'),
    ('Pedro Santos','1999-03-15','923456789','pedro@email.com'),
    ('Ana Costa','2001-07-20','934567890','ana@email.com'),
    ('Luis Pinto','1998-11-02','945678901','luis@email.com'),
    ('Carla Dias','2002-01-25','956789012','carla@email.com');

-- Consultas de teste simples
SELECT * FROM FORMANDO_Teste;