-- Comandos de Cadastro e Alteração

-- a) Cadastro dos Dados do Usuário
INSERT INTO "Usuario" 
  ("ID_Usuario", "Nome", "Email", "Senha", "Data_Cadastro", "Tipo_Usuario", "Meta_Financeira")
VALUES 
  ('[ID_USUARIO]', '[NOME]', '[EMAIL]', '[SENHA]', TO_DATE('[DATA_CADASTRO]', 'YYYY-MM-DD'), '[TIPO_USUARIO]', [META_FINANCEIRA]);


-- b) Cadastro dos Dados da Conta do Usuário
INSERT INTO "Conta_Financeira" 
  ("ID_Conta", "Tipo_Conta", "Saldo", "Data_Abertura", "Status", "ID_Usuario", "ID_Banco")
VALUES 
  ('[ID_CONTA]', '[TIPO_CONTA]', [SALDO], TO_DATE('[DATA_ABERTURA]', 'YYYY-MM-DD'), '[STATUS]', '[ID_USUARIO]', '[ID_BANCO]');


-- c) Alteração dos Dados do Usuário (por código)
UPDATE "Usuario"
SET 
  "Nome" = '[NOME]',
  "Email" = '[EMAIL]',
  "Senha" = '[SENHA]',
  "Data_Cadastro" = TO_DATE('[DATA_CADASTRO]', 'YYYY-MM-DD'),
  "Tipo_Usuario" = '[TIPO_USUARIO]',
  "Meta_Financeira" = [META_FINANCEIRA]
WHERE 
  "ID_Usuario" = '[ID_USUARIO]';

-- d) Cadastro de Receita do Usuário
-- Observação: Utilizamos a tabela "Transacao" com o campo "Tipo" igual a 'Receita'.
INSERT INTO "Transacao" 
  ("ID_Transacao", "Data", "Tipo", "Valor", "Descricao", "Categoria", "ID_Conta", "ID_Meta")
VALUES 
  ('[ID_TRANSACAO]', TO_DATE('[DATA_TRANSACAO]', 'YYYY-MM-DD'), 'Receita', [VALOR], '[DESCRICAO]', '[CATEGORIA]', '[ID_CONTA]', '[ID_META]');


-- e) Alteração da Receita do Usuário (por código)
UPDATE "Transacao"
SET 
  "Data" = TO_DATE('[DATA_TRANSACAO]', 'YYYY-MM-DD'),
  "Tipo" = 'Receita',
  "Valor" = [VALOR],
  "Descricao" = '[DESCRICAO]',
  "Categoria" = '[CATEGORIA]',
  "ID_Conta" = '[ID_CONTA]',
  "ID_Meta" = '[ID_META]'
WHERE 
  "ID_Transacao" = '[ID_TRANSACAO]' 
  AND "Tipo" = 'Receita';


-- f) Cadastro de Despesa do Usuário
-- Observação: Novamente, utilizamos a tabela "Transacao", agora com o campo "Tipo" igual a 'Despesa'.
INSERT INTO "Transacao" 
  ("ID_Transacao", "Data", "Tipo", "Valor", "Descricao", "Categoria", "ID_Conta", "ID_Meta")
VALUES 
  ('[ID_TRANSACAO]', TO_DATE('[DATA_TRANSACAO]', 'YYYY-MM-DD'), 'Despesa', [VALOR], '[DESCRICAO]', '[CATEGORIA]', '[ID_CONTA]', '[ID_META]');


-- g) Alteração da Despesa do Usuário (por código)
UPDATE "Transacao"
SET 
  "Data" = TO_DATE('[DATA_TRANSACAO]', 'YYYY-MM-DD'),
  "Tipo" = 'Despesa',
  "Valor" = [VALOR],
  "Descricao" = '[DESCRICAO]',
  "Categoria" = '[CATEGORIA]',
  "ID_Conta" = '[ID_CONTA]',
  "ID_Meta" = '[ID_META]'
WHERE 
  "ID_Transacao" = '[ID_TRANSACAO]' 
  AND "Tipo" = 'Despesa';

-- h) Cadastro dos Dados para Investimentos
INSERT INTO "Investimento" 
  ("ID_Investimento", "Tipo_Investimento", "Valor_Inicial", "Rentabilidade", "Data_Inicio", "Data_Final", "Status", "ID_Conta")
VALUES 
  ('[ID_INVESTIMENTO]', '[TIPO_INVESTIMENTO]', [VALOR_INICIAL], [RENTABILIDADE], TO_DATE('[DATA_INICIO]', 'YYYY-MM-DD'),
   TO_DATE('[DATA_FINAL]', 'YYYY-MM-DD'), '[STATUS_INVESTIMENTO]', '[ID_CONTA]');

-- i) Alteração dos Dados para Investimentos (por código)
UPDATE "Investimento"
SET 
  "Tipo_Investimento" = '[TIPO_INVESTIMENTO]',
  "Valor_Inicial" = [VALOR_INICIAL],
  "Rentabilidade" = [RENTABILIDADE],
  "Data_Inicio" = TO_DATE('[DATA_INICIO]', 'YYYY-MM-DD'),
  "Data_Final" = TO_DATE('[DATA_FINAL]', 'YYYY-MM-DD'),
  "Status" = '[STATUS_INVESTIMENTO]',
  "ID_Conta" = '[ID_CONTA]'
WHERE 
  "ID_Investimento" = '[ID_INVESTIMENTO]';


-- 2. Comandos de Consulta

-- a) Consultar os Dados de um Usuário (por código)
SELECT "ID_Usuario", "Nome", "Email", "Senha", "Data_Cadastro", "Tipo_Usuario", "Meta_Financeira"
FROM "Usuario"
WHERE "ID_Usuario" = '[ID_USUARIO]';

-- b) Consultar um Único Registro de Despesa (por código do usuário e da despesa)
SELECT t."ID_Transacao", t."Data", t."Tipo", t."Valor", t."Descricao", t."Categoria", t."ID_Conta", t."ID_Meta"
FROM "Transacao" t
JOIN "Conta_Financeira" c ON t."ID_Conta" = c."ID_Conta"
WHERE c."ID_Usuario" = '[ID_USUARIO]'
  AND t."ID_Transacao" = '[ID_DESPESA]'
  AND t."Tipo" = 'Despesa';


-- c) Consultar Todos os Registros de Despesas do Usuário (ordenados do mais recente para o mais antigo)
SELECT t."ID_Transacao", t."Data", t."Tipo", t."Valor", t."Descricao", t."Categoria", t."ID_Conta", t."ID_Meta"
FROM "Transacao" t
JOIN "Conta_Financeira" c ON t."ID_Conta" = c."ID_Conta"
WHERE c."ID_Usuario" = '[ID_USUARIO]'
  AND t."Tipo" = 'Despesa'
ORDER BY t."Data" DESC;


-- d) Consultar um Único Registro de Investimento (por código do usuário e do investimento)
SELECT i."ID_Investimento", i."Tipo_Investimento", i."Valor_Inicial", i."Rentabilidade", 
        i."Data_Inicio", i."Data_Final", i."Status", i."ID_Conta"
FROM "Investimento" i
JOIN "Conta_Financeira" c ON i."ID_Conta" = c."ID_Conta"
WHERE c."ID_Usuario" = '[ID_USUARIO]'
  AND i."ID_Investimento" = '[ID_INVESTIMENTO]';


-- e) Consultar Todos os Registros de Investimentos do Usuário (ordenados do mais recente para o mais antigo)
SELECT i."ID_Investimento", i."Tipo_Investimento", i."Valor_Inicial", i."Rentabilidade", 
        i."Data_Inicio", i."Data_Final", i."Status", i."ID_Conta"
FROM "Investimento" i
JOIN "Conta_Financeira" c ON i."ID_Conta" = c."ID_Conta"
WHERE c."ID_Usuario" = '[ID_USUARIO]'
ORDER BY i."Data_Inicio" DESC;


-- f) Consulta para o Dashboard: Dados Básicos do Usuário, Último Investimento e Última Despesa
SELECT u."ID_Usuario", u."Nome", u."Email",
        (SELECT i."Tipo_Investimento" 
          FROM "Investimento" i
          JOIN "Conta_Financeira" c ON i."ID_Conta" = c."ID_Conta"
          WHERE c."ID_Usuario" = u."ID_Usuario"
          ORDER BY i."Data_Inicio" DESC FETCH FIRST 1 ROWS ONLY) AS Ultimo_Investimento,
        (SELECT t."Descricao" 
          FROM "Transacao" t
          JOIN "Conta_Financeira" c ON t."ID_Conta" = c."ID_Conta"
          WHERE c."ID_Usuario" = u."ID_Usuario" AND t."Tipo" = 'Despesa'
          ORDER BY t."Data" DESC FETCH FIRST 1 ROWS ONLY) AS Ultima_Despesa
FROM "Usuario" u
WHERE u."ID_Usuario" = '[ID_USUARIO]';
