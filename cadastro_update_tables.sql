-- Comandos de Cadastro e Alteração

-- a) Cadastro dos Dados do Usuário

INSERT INTO T_FIN_USUARIO 
  (nr_usuario, nm_usuario, ds_email, ds_senha, dt_cadastro, cd_tipo_usuario, vl_meta_financeira)
VALUES 
  ('[NR_USUARIO]', '[NM_USUARIO]', '[DS_EMAIL]', '[DS_SENHA]', TO_DATE('[DT_CADASTRO]', 'YYYY-MM-DD'), '[CD_TIPO_USUARIO]', [VL_META_FINANCEIRA]);


-- b) Cadastro dos Dados da Conta do Usuário

INSERT INTO T_FIN_CONTA 
  (nr_conta, cd_tipo_conta, vl_saldo, dt_abertura, cd_status, nr_usuario, nr_banco)
VALUES 
  ('[NR_CONTA]', '[CD_TIPO_CONTA]', [VL_SALDO], TO_DATE('[DT_ABERTURA]', 'YYYY-MM-DD'), '[CD_STATUS]', '[NR_USUARIO]', '[NR_BANCO]');
--


-- c) Alteração dos Dados do Usuário (por código)

UPDATE T_FIN_USUARIO
SET 
  nm_usuario = '[NM_USUARIO]',
  ds_email = '[DS_EMAIL]',
  ds_senha = '[DS_SENHA]',
  dt_cadastro = TO_DATE('[DT_CADASTRO]', 'YYYY-MM-DD'),
  cd_tipo_usuario = '[CD_TIPO_USUARIO]',
  vl_meta_financeira = [VL_META_FINANCEIRA]
WHERE 
  nr_usuario = '[NR_USUARIO]';



INSERT INTO T_FIN_TRANSACAO 
  (nr_transacao, dt_transacao, cd_tipo, vl_transacao, ds_transacao, cd_categoria, nr_conta, nr_meta)
VALUES 
  ('[NR_TRANSACAO]', TO_DATE('[DT_TRANSACAO]', 'YYYY-MM-DD'), 'Receita', [VL_TRANSACAO], '[DS_TRANSACAO]', '[CD_CATEGORIA]', '[NR_CONTA]', '[NR_META]');


-- d) Cadastro de Receita do Usuário
-- Observação: Utilizamos a tabela "Transacao" com o campo "Tipo" igual a 'Receita'.

INSERT INTO T_FIN_TRANSACAO 
  (nr_transacao, dt_transacao, cd_tipo, vl_transacao, ds_transacao, cd_categoria, nr_conta, nr_meta)
VALUES 
  ('[NR_TRANSACAO]', TO_DATE('[DT_TRANSACAO]', 'YYYY-MM-DD'), 'Receita', [VL_TRANSACAO], '[DS_TRANSACAO]', '[CD_CATEGORIA]', '[NR_CONTA]', '[NR_META]');


-- e) Alteração da Receita do Usuário (por código)

UPDATE T_FIN_TRANSACAO
SET 
  dt_transacao = TO_DATE('[DT_TRANSACAO]', 'YYYY-MM-DD'),
  cd_tipo = 'Receita',
  vl_transacao = [VL_TRANSACAO],
  ds_transacao = '[DS_TRANSACAO]',
  cd_categoria = '[CD_CATEGORIA]',
  nr_conta = '[NR_CONTA]',
  nr_meta = '[NR_META]'
WHERE 
  nr_transacao = '[NR_TRANSACAO]' 
  AND cd_tipo = 'Receita';


-- f) Cadastro de Despesa do Usuário
-- Observação: Novamente, utilizamos a tabela "Transacao", agora com o campo "Tipo" igual a 'Despesa'.

INSERT INTO T_FIN_TRANSACAO 
  (nr_transacao, dt_transacao, cd_tipo, vl_transacao, ds_transacao, cd_categoria, nr_conta, nr_meta)
VALUES 
  ('[NR_TRANSACAO]', TO_DATE('[DT_TRANSACAO]', 'YYYY-MM-DD'), 'Despesa', [VL_TRANSACAO], '[DS_TRANSACAO]', '[CD_CATEGORIA]', '[NR_CONTA]', '[NR_META]');


-- g) Alteração da Despesa do Usuário (por código)

UPDATE T_FIN_TRANSACAO
SET 
  dt_transacao = TO_DATE('[DT_TRANSACAO]', 'YYYY-MM-DD'),
  cd_tipo = 'Despesa',
  vl_transacao = [VL_TRANSACAO],
  ds_transacao = '[DS_TRANSACAO]',
  cd_categoria = '[CD_CATEGORIA]',
  nr_conta = '[NR_CONTA]',
  nr_meta = '[NR_META]'
WHERE 
  nr_transacao = '[NR_TRANSACAO]' 
  AND cd_tipo = 'Despesa';


-- h) Cadastro dos Dados para Investimentos
INSERT INTO T_FIN_INVESTIMENTO 
  (nr_investimento, cd_tipo_investimento, vl_inicial, vl_rentabilidade, dt_inicio, dt_final, cd_status, nr_conta)
VALUES 
  ('[NR_INVESTIMENTO]', '[CD_TIPO_INVESTIMENTO]', [VL_INICIAL], [VL_RENTABILIDADE], TO_DATE('[DT_INICIO]', 'YYYY-MM-DD'),
   TO_DATE('[DT_FINAL]', 'YYYY-MM-DD'), '[CD_STATUS_INVESTIMENTO]', '[NR_CONTA]');


-- i) Alteração dos Dados para Investimentos (por código)

UPDATE T_FIN_INVESTIMENTO
SET 
  cd_tipo_investimento = '[CD_TIPO_INVESTIMENTO]',
  vl_inicial = [VL_INICIAL],
  vl_rentabilidade = [VL_RENTABILIDADE],
  dt_inicio = TO_DATE('[DT_INICIO]', 'YYYY-MM-DD'),
  dt_final = TO_DATE('[DT_FINAL]', 'YYYY-MM-DD'),
  cd_status = '[CD_STATUS_INVESTIMENTO]',
  nr_conta = '[NR_CONTA]'
WHERE 
  nr_investimento = '[NR_INVESTIMENTO]';

-- 2. Comandos de Consulta

-- a) Seleciona todos os dados do usuário
SELECT nr_usuario, nm_usuario, ds_email, ds_senha, dt_cadastro, cd_tipo_usuario, vl_meta_financeira
FROM T_FIN_USUARIO
WHERE nr_usuario = '[NR_USUARIO]';
--

-- b) Consultar um Único Registro de Despesa (por código do usuário e da despesa)

SELECT t.nr_transacao, t.dt_transacao, t.cd_tipo, t.vl_transacao, t.ds_transacao, t.cd_categoria, t.nr_conta, t.nr_meta
FROM T_FIN_TRANSACAO t
JOIN T_FIN_CONTA c ON t.nr_conta = c.nr_conta
WHERE c.nr_usuario = '[NR_USUARIO]'
  AND t.nr_transacao = '[NR_DESPESA]'
  AND t.cd_tipo = 'Despesa';

--

-- c) Consultar Todos os Registros de Despesas do Usuário (ordenados do mais recente para o mais antigo)

SELECT t.nr_transacao, t.dt_transacao, t.cd_tipo, t.vl_transacao, t.ds_transacao, t.cd_categoria, t.nr_conta, t.nr_meta
FROM T_FIN_TRANSACAO t
JOIN T_FIN_CONTA c ON t.nr_conta = c.nr_conta
WHERE c.nr_usuario = '[NR_USUARIO]'
  AND t.cd_tipo = 'Despesa'
ORDER BY t.dt_transacao DESC;

-- d) Consultar um Único Registro de Investimento (por código do usuário e do investimento)
SELECT i.nr_investimento, i.cd_tipo_investimento, i.vl_inicial, i.vl_rentabilidade,
       i.dt_inicio, i.dt_final, i.cd_status, i.nr_conta
FROM T_FIN_INVESTIMENTO i
JOIN T_FIN_CONTA c ON i.nr_conta = c.nr_conta
WHERE c.nr_usuario = '[NR_USUARIO]'
  AND i.nr_investimento = '[NR_INVESTIMENTO]';



-- e) Consultar Todos os Registros de Investimentos do Usuário (ordenados do mais recente para o mais antigo)
SELECT i.nr_investimento, i.cd_tipo_investimento, i.vl_inicial, i.vl_rentabilidade,
       i.dt_inicio, i.dt_final, i.cd_status, i.nr_conta
FROM T_FIN_INVESTIMENTO i
JOIN T_FIN_CONTA c ON i.nr_conta = c.nr_conta
WHERE c.nr_usuario = '[NR_USUARIO]'
ORDER BY i.dt_inicio DESC;

-- f) Consulta para o Dashboard: Dados Básicos do Usuário, Último Investimento e Última Despesa

SELECT u.nr_usuario AS ID_Usuario,
       u.nm_usuario AS Nome,
       u.ds_email AS Email,
       (SELECT i.cd_tipo_investimento 
        FROM T_FIN_INVESTIMENTO i
        JOIN T_FIN_CONTA c ON i.nr_conta = c.nr_conta
        WHERE c.nr_usuario = u.nr_usuario
        ORDER BY i.dt_inicio DESC FETCH FIRST ROW ONLY) AS Ultimo_Investimento,
       (SELECT t.ds_transacao 
        FROM T_FIN_TRANSACAO t
        JOIN T_FIN_CONTA c ON t.nr_conta = c.nr_conta
        WHERE c.nr_usuario = u.nr_usuario AND t.cd_tipo = 'Despesa'
        ORDER BY t.dt_transacao DESC FETCH FIRST ROW ONLY) AS Ultima_Despesa
FROM T_FIN_USUARIO u
WHERE u.nr_usuario = '[NR_USUARIO]';
