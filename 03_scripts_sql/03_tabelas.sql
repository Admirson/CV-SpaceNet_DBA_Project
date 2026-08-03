/* ============================================================
   						CRIAÇÃO DAS TABELAS 
   ============================================================ */

/* ------------------------------------------------------------
   SCHEMA: core
   Tabela: satelite
   ------------------------------------------------------------ */
CREATE TABLE core.satelite (
    id_satelite SERIAL PRIMARY KEY,                   
    nome VARCHAR(100) NOT NULL,                         
    agencia VARCHAR(100) NOT NULL,                      
    data_lancamento DATE,                               
    estado VARCHAR(20) DEFAULT 'ativo'                  
        CHECK (estado IN ('ativo','inativo','manutencao'))  
);

/* ------------------------------------------------------------
   SCHEMA: pesca
   Tabela: embarcacao
   ------------------------------------------------------------ */
CREATE TABLE pesca.embarcacao (
    id_embarcacao SERIAL PRIMARY KEY,                   
    nome VARCHAR(120) NOT NULL,                         
    pais_bandeira VARCHAR(50) NOT NULL,                
    tipo VARCHAR(50),
    imo VARCHAR(20) UNIQUE                             
);

/* ------------------------------------------------------------
   SCHEMA: pesca
   Tabela: evento_pesca_ilegal
   ------------------------------------------------------------ */
CREATE TABLE pesca.evento_pesca_ilegal (
    id_evento SERIAL PRIMARY KEY,                       
    id_embarcacao INT NOT NULL,                         
    id_satelite INT NOT NULL,                          
    data_evento TIMESTAMP NOT NULL,                    
    latitude DECIMAL(10,6) NOT NULL,                   
    longitude DECIMAL(10,6) NOT NULL,                   
    descricao TEXT,

    FOREIGN KEY (id_embarcacao) REFERENCES pesca.embarcacao(id_embarcacao),
    FOREIGN KEY (id_satelite) REFERENCES core.satelite(id_satelite)
);

/* ------------------------------------------------------------
   SCHEMA: meteo
   Tabela: observacao_bruma
   ------------------------------------------------------------ */
CREATE TABLE meteo.observacao_bruma (
    id_observacao SERIAL PRIMARY KEY,                 
    id_satelite INT NOT NULL,                         
    data_observacao TIMESTAMP NOT NULL,                
    densidade_poeria DECIMAL(6,2)
        CHECK (densidade_poeria >= 0),                  
    visibilidade_km DECIMAL(6,2),
    temperatura DECIMAL(4,1),
    humidade DECIMAL(4,1),

    FOREIGN KEY (id_satelite) REFERENCES core.satelite(id_satelite)
);

/* ------------------------------------------------------------
   SCHEMA: geo
   Tabela: imagem
   ------------------------------------------------------------ */
CREATE TABLE geo.imagem (
    id_imagem SERIAL PRIMARY KEY,                      
    id_satelite INT NOT NULL,                          
    data_captura TIMESTAMP NOT NULL,                  
    resolucao VARCHAR(50),
    caminho_ficheiro VARCHAR(255) NOT NULL UNIQUE,     

    FOREIGN KEY (id_satelite) REFERENCES core.satelite(id_satelite)
);