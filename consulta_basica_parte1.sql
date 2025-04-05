----------------------------------------------------------------
-- Criação da Tabela "Usuario" 
CREATE TABLE "Usuario" (
  "ID_Usuario"      VARCHAR2(36) PRIMARY KEY,
  "Nome"            VARCHAR2(100),
  "Email"           VARCHAR2(255),
  "Senha"           VARCHAR2(255),
  "Data_Cadastro"   DATE,
  "Tipo_Usuario"    VARCHAR2(20),
  "Meta_Financeira" NUMBER
);

-- Inserção de um registro funcional em "Usuario"
INSERT INTO "Usuario"
("ID_Usuario", "Nome", "Email", "Senha", "Data_Cadastro", "Tipo_Usuario", "Meta_Financeira")
VALUES
(
  'a1b2c3d4-e5f6-7890-abcd-ef1234567890',  -- valor para ID_Usuario
  'Fulano de Tal',                         -- valor para Nome
  'fulano@exemplo.com',                    -- valor para Email
  'senha123',                              -- valor para Senha
  TO_DATE('2025-04-03', 'YYYY-MM-DD'),       -- valor para Data_Cadastro
  'Comum',                                 -- valor para Tipo_Usuario
  1000.00                                  -- valor para Meta_Financeira
);

----------------------------------------------------------------
-- Criação da Tabela "Conta_Financeira"
CREATE TABLE "Conta_Financeira" (
  "ID_Conta"      VARCHAR2(36) PRIMARY KEY,
  "Tipo_Conta"    VARCHAR2(20),
  "Saldo"         NUMBER,
  "Data_Abertura" DATE,
  "Status"        VARCHAR2(20),
  "ID_Usuario"    VARCHAR2(36),
  "ID_Banco"      VARCHAR2(36)
);

-- Inserção de um registro funcional em "Conta_Financeira"
INSERT INTO "Conta_Financeira"
("ID_Conta", "Tipo_Conta", "Saldo", "Data_Abertura", "Status", "ID_Usuario", "ID_Banco")
VALUES
(
  'conta-uuid-exemplo',                      -- valor para ID_Conta
  'Corrente',                                -- valor para Tipo_Conta
  500.00,                                    -- valor para Saldo
  TO_DATE('2025-04-03', 'YYYY-MM-DD'),         -- valor para Data_Abertura
  'Ativa',                                   -- valor para Status
  'a1b2c3d4-e5f6-7890-abcd-ef1234567890',      -- valor para ID_Usuario
  'banco-uuid-exemplo'                       -- valor para ID_Banco
);

----------------------------------------------------------------
-- Criação da Tabela "Investimento" 
CREATE TABLE "Investimento" (
  "ID_Investimento"   VARCHAR2(36) PRIMARY KEY,
  "Tipo_Investimento" VARCHAR2(50),
  "Valor_Inicial"     NUMBER,
  "Rentabilidade"     NUMBER,
  "Data_Inicio"       DATE,
  "Data_Final"        DATE,
  "Status"            VARCHAR2(20),
  "ID_Conta"          VARCHAR2(36)
);

-- Inserção de um registro funcional em "Investimento"
INSERT INTO "Investimento"
("ID_Investimento", "Tipo_Investimento", "Valor_Inicial", "Rentabilidade", "Data_Inicio", "Data_Final", "Status", "ID_Conta")
VALUES
(
  'investimento-uuid-exemplo',                 -- valor para ID_Investimento
  'Acoes',                                     -- valor para Tipo_Investimento
  5000.00,                                     -- valor para Valor_Inicial
  0.08,                                        -- valor para Rentabilidade
  TO_DATE('2025-04-01', 'YYYY-MM-DD'),           -- valor para Data_Inicio
  TO_DATE('2026-04-01', 'YYYY-MM-DD'),           -- valor para Data_Final
  'Ativo',                                     -- valor para Status
  'conta-uuid-exemplo'                         -- valor para ID_Conta
);

----------------------------------------------------------------
-- Criação da Tabela "Transacao" 
CREATE TABLE "Transacao" (
  "ID_Transacao"  VARCHAR2(36) PRIMARY KEY,
  "Data"          DATE,
  "Tipo"          VARCHAR2(50),
  "Valor"         NUMBER,
  "Descricao"     VARCHAR2(255),
  "Categoria"     VARCHAR2(50),
  "ID_Conta"      VARCHAR2(36),
  "ID_Meta"       VARCHAR2(36)
);

-- Inserção de um registro funcional em "Transacao" para Receita
INSERT INTO "Transacao"
("ID_Transacao", "Data", "Tipo", "Valor", "Descricao", "Categoria", "ID_Conta", "ID_Meta")
VALUES
(
  'transacao-receita-uuid-exemplo',         -- valor para ID_Transacao
  TO_DATE('2025-04-04', 'YYYY-MM-DD'),        -- valor para Data
  'Receita',                                  -- valor para Tipo
  2000.00,                                    -- valor para Valor
  'Salario',                                  -- valor para Descricao
  'Renda',                                    -- valor para Categoria
  'conta-uuid-exemplo',                       -- valor para ID_Conta
  'meta-uuid-exemplo'                         -- valor para ID_Meta
);

-- Inserção de um registro funcional em "Transacao" para Despesa
INSERT INTO "Transacao"
("ID_Transacao", "Data", "Tipo", "Valor", "Descricao", "Categoria", "ID_Conta", "ID_Meta")
VALUES
(
  'transacao-despesa-uuid-exemplo',         -- valor para ID_Transacao
  TO_DATE('2025-04-05', 'YYYY-MM-DD'),        -- valor para Data
  'Despesa',                                  -- valor para Tipo
  300.00,                                     -- valor para Valor
  'Conta de Luz',                             -- valor para Descricao
  'Servicos',                                 -- valor para Categoria
  'conta-uuid-exemplo',                       -- valor para ID_Conta
  'meta-uuid-exemplo'                         -- valor para ID_Meta
);

----------------------------------------------------------------
-- Consultas Adicionais

-- 1) Seleciona todos os dados do usuário com um ID específico.
SELECT * FROM "Usuario"
WHERE "ID_Usuario" = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';

-- 2) Seleciona um registro específico de despesa na tabela "Transacao"
-- Filtrando pelo ID do usuário (através da conta), ID da transação e Tipo 'Despesa'.
SELECT * FROM "Transacao"
WHERE "ID_Conta" IN (
    SELECT "ID_Conta" FROM "Conta_Financeira"
    WHERE "ID_Usuario" = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
)
AND "ID_Transacao" = 'transacao-despesa-uuid-exemplo'
AND "Tipo" = 'Despesa';

-- 3) Seleciona todos os registros de despesas do usuário, ordenados da data mais recente para a mais antiga.
SELECT * FROM "Transacao"
WHERE "ID_Conta" IN (
    SELECT "ID_Conta" FROM "Conta_Financeira"
    WHERE "ID_Usuario" = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
)
AND "Tipo" = 'Despesa'
ORDER BY "Data" DESC;

-- 4) Seleciona um registro específico de investimento filtrando pelo ID do investimento,
-- considerando as contas do usuário.
SELECT * FROM "Investimento"
WHERE "ID_Conta" IN (
    SELECT "ID_Conta" FROM "Conta_Financeira"
    WHERE "ID_Usuario" = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
)
AND "ID_Investimento" = 'investimento-uuid-exemplo';

-- 5) Seleciona todos os investimentos do usuário, ordenados por Data_Inicio de forma decrescente.
SELECT * FROM "Investimento"
WHERE "ID_Conta" IN (
    SELECT "ID_Conta" FROM "Conta_Financeira"
    WHERE "ID_Usuario" = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
)
ORDER BY "Data_Inicio" DESC;


----------------------------------------------------------------
-- Consulta para o Dashboard:
-- Retorna os dados básicos do usuário, o último investimento e a última despesa.
SELECT 
  u."ID_Usuario",                -- Identificador do usuário
  u."Nome",                      -- Nome do usuário
  u."Email",                     -- Email do usuário
  (SELECT i."Tipo_Investimento"  -- Subconsulta para obter o último investimento
      FROM "Investimento" i
      JOIN "Conta_Financeira" c ON i."ID_Conta" = c."ID_Conta"
    WHERE c."ID_Usuario" = u."ID_Usuario"
    ORDER BY i."Data_Inicio" DESC FETCH FIRST 1 ROWS ONLY) AS Ultimo_Investimento,
  (SELECT t."Descricao"         -- Subconsulta para obter a última despesa
      FROM "Transacao" t
      JOIN "Conta_Financeira" c ON t."ID_Conta" = c."ID_Conta"
    WHERE c."ID_Usuario" = u."ID_Usuario" AND t."Tipo" = 'Despesa'
    ORDER BY t."Data" DESC FETCH FIRST 1 ROWS ONLY) AS Ultima_Despesa
FROM "Usuario" u
WHERE u."ID_Usuario" = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';