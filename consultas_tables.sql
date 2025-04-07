
-- 1) Seleciona todos os dados do usuário com um ID específico.
SELECT * FROM T_FIN_USUARIO
WHERE NR_USUARIO = 'user-001';

-- 2) Seleciona um registro específico de despesa na tabela "Transacao"
-- Filtrando pelo ID do usuário (através da conta), ID da transação e Tipo 'Despesa'.
SELECT * FROM T_FIN_TRANSACAO
WHERE NR_CONTA IN (
    SELECT NR_CONTA FROM T_FIN_CONTA
    WHERE NR_USUARIO= 'user-001'
)AND NR_CONTA = 'conta-001'
  AND CD_TIPO = 'Receita';

-- 3) Seleciona todos os registros de despesas do usuário, ordenados da data mais recente para a mais antiga.
SELECT * FROM T_FIN_TRANSACAO T
WHERE  T.NR_CONTA IN (
    SELECT NR_CONTA FROM T_FIN_CONTA
    WHERE NR_USUARIO = 'user-001'
)
  AND CD_TIPO = 'Despesa'
ORDER BY DT_TRANSACAO DESC;


-- 4) Seleciona um registro específico de investimento filtrando pelo ID do investimento,
-- considerando as contas do usuário.

SELECT * FROM T_FIN_INVESTIMENTO
WHERE NR_CONTA IN (
    SELECT NR_CONTA FROM T_FIN_CONTA
    WHERE NR_USUARIO = 'user-001'
)
  AND NR_INVESTIMENTO = 'inv-001';

-- 5) Seleciona todos os investimentos do usuário, ordenados por Data_Inicio de forma decrescente.
SELECT * FROM T_FIN_INVESTIMENTO
WHERE NR_CONTA IN (
    SELECT NR_CONTA FROM T_FIN_CONTA
    WHERE NR_USUARIO = 'user-001'
)ORDER BY DT_INICIO DESC;


-- Consulta para o Dashboard:
-- Retorna os dados básicos do usuário, o último investimento e a última despesa.
-- Consulta para o Dashboard:
-- Retorna os dados básicos do usuário, o último investimento e a última despesa.
SELECT
    u.NR_USUARIO,                             -- Identificador do usuário
    u.NM_USUARIO,                             -- Nome do usuário
    u.DS_EMAIL,                               -- Email do usuário

    -- Subconsulta para obter o último investimento
    (SELECT i.CD_TIPO_INVESTIMENTO
     FROM T_FIN_INVESTIMENTO i
              JOIN T_FIN_CONTA c ON i.NR_CONTA = c.NR_CONTA
     WHERE c.NR_USUARIO = u.NR_USUARIO
     ORDER BY i.DT_INICIO DESC
         FETCH FIRST 1 ROWS ONLY) AS Ultimo_Investimento,

    -- Subconsulta para obter a descrição da última despesa
    (SELECT t.DS_TRANSACAO
     FROM T_FIN_TRANSACAO t
              JOIN T_FIN_CONTA c ON t.NR_CONTA = c.NR_CONTA
     WHERE c.NR_USUARIO = u.NR_USUARIO AND t.CD_TIPO = 'Despesa'
     ORDER BY t.DT_TRANSACAO DESC
         FETCH FIRST 1 ROWS ONLY) AS Ultima_Despesa

FROM T_FIN_USUARIO u
WHERE u.NR_USUARIO = 'user-001';
