-- Script para criar as tabelas da tarefa do capitulo 07 - Projeto Fintech
-- ----------------------------------------------------------------
-- -- Criação da Tabela "Usuario"
-- -- Criação da Tabela "Banco"
-- -- Criação da Tabela "Meta_Financeira"
-- -- Criação da Tabela "Transacao"
-- -- Criação da Tabela "Investimento"
-- -- Criação da Tabela "Divida"
-- -- Criação da Tabela "Recomendacao"
--- ----------------------------------------------------------------
-- ----------------------------------------------------------------

-- Tabela de Usuários
CREATE TABLE T_FIN_USUARIO (
  nr_usuario VARCHAR2(36) PRIMARY KEY,
  nm_usuario VARCHAR2(100),
  ds_email VARCHAR2(255),
  ds_senha VARCHAR2(255),
  dt_cadastro DATE,
  cd_tipo_usuario VARCHAR2(20),
  vl_meta_financeira NUMBER
);

-- ----------------------------------------------------------------

-- Tabela de Banco 
CREATE TABLE T_FIN_BANCO (
  nr_banco VARCHAR2(36) PRIMARY KEY,
  cd_ispb VARCHAR2(10),
  cd_compe VARCHAR2(3),
  cd_swift VARCHAR2(11),
  nm_banco VARCHAR2(100),
  ds_site VARCHAR2(255),
  nr_telefone VARCHAR2(20),
  cd_status VARCHAR2(10)
);

-- ----------------------------------------------------------------

-- Tabela de Conta 
CREATE TABLE T_FIN_CONTA (
  nr_conta VARCHAR2(36) PRIMARY KEY,
  cd_tipo_conta VARCHAR2(20),
  vl_saldo NUMBER,
  dt_abertura DATE,
  cd_status VARCHAR2(20),
  nr_usuario VARCHAR2(36),
  nr_banco VARCHAR2(36),
  CONSTRAINT FK_FIN_CONT_USUA FOREIGN KEY (nr_usuario) REFERENCES T_FIN_USUARIO (nr_usuario),
  CONSTRAINT FK_FIN_CONT_BANC FOREIGN KEY (nr_banco) REFERENCES T_FIN_BANCO (nr_banco)
);

-- ----------------------------------------------------------------

-- Tabela de Meta Financeira 
CREATE TABLE T_FIN_META (
  nr_meta VARCHAR2(36) PRIMARY KEY,
  ds_meta VARCHAR2(255),
  vl_objetivo NUMBER,
  dt_inicio DATE,
  dt_final DATE,
  cd_status VARCHAR2(50),
  nr_usuario VARCHAR2(36),
  CONSTRAINT FK_FIN_META_USUA FOREIGN KEY (nr_usuario) REFERENCES T_FIN_USUARIO (nr_usuario)
);

-- ----------------------------------------------------------------

-- Tabela de Transação 
CREATE TABLE T_FIN_TRANSACAO (
  nr_transacao VARCHAR2(36) PRIMARY KEY,
  dt_transacao DATE,
  cd_tipo VARCHAR2(50),
  vl_transacao NUMBER,
  ds_transacao VARCHAR2(255),
  cd_categoria VARCHAR2(50),
  nr_conta VARCHAR2(36),
  nr_meta VARCHAR2(36),
  CONSTRAINT FK_FIN_TRAN_CONT FOREIGN KEY (nr_conta) REFERENCES T_FIN_CONTA (nr_conta),
  CONSTRAINT FK_FIN_TRAN_META FOREIGN KEY (nr_meta) REFERENCES T_FIN_META (nr_meta)
);

-- ----------------------------------------------------------------

-- Tabela de Investimentos 
CREATE TABLE T_FIN_INVESTIMENTO (
  nr_investimento VARCHAR2(36) PRIMARY KEY,
  cd_tipo_investimento VARCHAR2(50),
  vl_inicial NUMBER,
  vl_rentabilidade NUMBER,
  dt_inicio DATE,
  dt_final DATE,
  cd_status VARCHAR2(20),
  nr_conta VARCHAR2(36),
  CONSTRAINT FK_FIN_INVE_CONT FOREIGN KEY (nr_conta) REFERENCES T_FIN_CONTA (nr_conta)
);

-- ----------------------------------------------------------------

-- Tabela de Dívidas 
CREATE TABLE T_FIN_DIVIDA (
  nr_divida VARCHAR2(36) PRIMARY KEY,
  vl_divida NUMBER,
  vl_juros NUMBER,
  dt_inicio DATE,
  dt_vencimento DATE,
  cd_status VARCHAR2(20),
  nr_usuario VARCHAR2(36),
  CONSTRAINT FK_FIN_DIVI_USUA FOREIGN KEY (nr_usuario) REFERENCES T_FIN_USUARIO (nr_usuario)
);

-- ----------------------------------------------------------------

-- Tabela de Recomendações
CREATE TABLE T_FIN_RECOMENDACAO (
  nr_recomendacao VARCHAR2(36) PRIMARY KEY,
  cd_tipo_recomendacao VARCHAR2(50),
  ds_recomendacao VARCHAR2(255),
  dt_geracao DATE,
  nr_usuario VARCHAR2(36),
  CONSTRAINT FK_FIN_RECO_USUA FOREIGN KEY (nr_usuario) REFERENCES T_FIN_USUARIO (nr_usuario)
);
--  
-- -----------------------------------------------------------------

