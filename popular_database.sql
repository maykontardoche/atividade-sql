



-- Inserção de um registro funcional em "Usuário"
INSERT INTO T_FIN_BANCO (
    nr_banco, cd_ispb, cd_compe, cd_swift, nm_banco, ds_site, nr_telefone, cd_status
) VALUES
    (
        'banco-001',
        '12345678',
        '001',
        'BCOEXEMP01',
        'Banco Exemplo S.A.',
        'https://bancoexemplo.com',
        '0800123456',
        'Ativo'

    );

INSERT INTO T_FIN_BANCO (
    nr_banco, cd_ispb, cd_compe, cd_swift, nm_banco, ds_site, nr_telefone, cd_status
) VALUES
(
    'banco-002',
    '87654321',
    '237',
    'BCOEXEMP02',
    'Banco Modelo LTDA.',
    'https://bancomodelo.com',
    '0800654321',
    'Ativo'
);


INSERT INTO T_FIN_USUARIO (
    nr_usuario, nm_usuario, ds_email, ds_senha, dt_cadastro, cd_tipo_usuario, vl_meta_financeira
) VALUES (
             'user-001', 'Fulano de Tal', 'fulano@exemplo.com', 'senha123', TO_DATE('2025-04-03', 'YYYY-MM-DD'), 'Comum', 1000.00
         );

INSERT INTO T_FIN_USUARIO (
    nr_usuario, nm_usuario, ds_email, ds_senha, dt_cadastro, cd_tipo_usuario, vl_meta_financeira
) VALUES (
             'user-002', 'Maria Oliveira', 'maria@exemplo.com', 'hashsenha', TO_DATE('2025-04-02', 'YYYY-MM-DD'), 'Premium', 5000.00
         );


INSERT INTO T_FIN_CONTA (
    nr_conta, cd_tipo_conta, vl_saldo, dt_abertura, cd_status, nr_usuario, nr_banco
) VALUES (
             'conta-001', 'Corrente', 1500.00, TO_DATE('2025-04-01', 'YYYY-MM-DD'), 'Ativa', 'user-001', 'banco-001'
         );

INSERT INTO T_FIN_CONTA (
    nr_conta, cd_tipo_conta, vl_saldo, dt_abertura, cd_status, nr_usuario, nr_banco
) VALUES (
             'conta-002', 'Poupança', 3200.00, TO_DATE('2025-04-02', 'YYYY-MM-DD'), 'Ativa', 'user-002', 'banco-002'
         );


INSERT INTO T_FIN_META (
    nr_meta, ds_meta, vl_objetivo, dt_inicio, dt_final, cd_status, nr_usuario
) VALUES (
             'meta-001', 'Viagem para Europa', 8000.00, TO_DATE('2025-04-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'), 'Em andamento', 'user-001'
         );

INSERT INTO T_FIN_META (
    nr_meta, ds_meta, vl_objetivo, dt_inicio, dt_final, cd_status, nr_usuario
) VALUES (
             'meta-002', 'Compra de carro', 30000.00, TO_DATE('2025-04-02', 'YYYY-MM-DD'), TO_DATE('2026-06-30', 'YYYY-MM-DD'), 'Em andamento', 'user-002'
         );

INSERT INTO T_FIN_TRANSACAO (
    nr_transacao, dt_transacao, cd_tipo, vl_transacao, ds_transacao, cd_categoria, nr_conta, nr_meta
) VALUES (
             'trans-001', TO_DATE('2025-04-04', 'YYYY-MM-DD'), 'Receita', 2000.00, 'Salario', 'Renda', 'conta-001', 'meta-001'
         );

INSERT INTO T_FIN_TRANSACAO (
    nr_transacao, dt_transacao, cd_tipo, vl_transacao, ds_transacao, cd_categoria, nr_conta, nr_meta
) VALUES (
             'trans-002', TO_DATE('2025-04-04', 'YYYY-MM-DD'), 'Receita', 1000.00, 'Salário', 'Renda', 'conta-002', 'meta-002'
         );

INSERT INTO T_FIN_INVESTIMENTO (
    nr_investimento, cd_tipo_investimento, vl_inicial, vl_rentabilidade, dt_inicio, dt_final, cd_status, nr_conta
) VALUES (
             'inv-001', 'Acoes', 1000.00, 5.0, TO_DATE('2025-04-01', 'YYYY-MM-DD'), TO_DATE('2026-04-01', 'YYYY-MM-DD'), 'Ativo', 'conta-001'
         );

INSERT INTO T_FIN_INVESTIMENTO (
    nr_investimento, cd_tipo_investimento, vl_inicial, vl_rentabilidade, dt_inicio, dt_final, cd_status, nr_conta
) VALUES (
             'inv-002', 'CDB', 1500.00, 6.5, TO_DATE('2025-04-02', 'YYYY-MM-DD'), TO_DATE('2026-04-02', 'YYYY-MM-DD'), 'Ativo', 'conta-002'
         );

INSERT INTO T_FIN_RECOMENDACAO (
    nr_recomendacao, cd_tipo_recomendacao, ds_recomendacao, dt_geracao, nr_usuario
) VALUES (
             'reco-001', 'Economia', 'Reduza os gastos com alimentação em 10%', TO_DATE('2025-04-03', 'YYYY-MM-DD'), 'user-001'
         );

INSERT INTO T_FIN_RECOMENDACAO (
    nr_recomendacao, cd_tipo_recomendacao, ds_recomendacao, dt_geracao, nr_usuario
) VALUES (
             'reco-002', 'Investimento', 'Aumente a aplicação em CDBs', TO_DATE('2025-04-03', 'YYYY-MM-DD'), 'user-002'
         );

-- ----------------------------------------------------------------
INSERT ALL
    -- Receitas para o usuário 1 sendo conta 1 
    INTO T_FIN_TRANSACAO (NR_TRANSACAO, NR_CONTA, CD_TIPO, VL_TRANSACAO, DS_TRANSACAO, DT_TRANSACAO)
VALUES ('receita-001', 'conta-001', 'Receita', 3500.00, 'Salário mensal', TO_DATE('2025-03-30', 'YYYY-MM-DD'))

INTO T_FIN_TRANSACAO (NR_TRANSACAO, NR_CONTA, CD_TIPO, VL_TRANSACAO, DS_TRANSACAO, DT_TRANSACAO)
VALUES ('receita-002', 'conta-001', 'Receita', 500.00, 'Freelancer design', TO_DATE('2025-03-28', 'YYYY-MM-DD'))

INTO T_FIN_TRANSACAO (NR_TRANSACAO, NR_CONTA, CD_TIPO, VL_TRANSACAO, DS_TRANSACAO, DT_TRANSACAO)
VALUES ('receita-003', 'conta-001', 'Receita', 250.00, 'Venda OLX', TO_DATE('2025-03-26', 'YYYY-MM-DD'))

-- Despesas para o usuário 1 sendo conta 1 
INTO T_FIN_TRANSACAO (NR_TRANSACAO, NR_CONTA, CD_TIPO, VL_TRANSACAO, DS_TRANSACAO, DT_TRANSACAO)
VALUES ('despesa-001', 'conta-001', 'Despesa', 120.00, 'Supermercado', TO_DATE('2025-04-01', 'YYYY-MM-DD'))

INTO T_FIN_TRANSACAO (NR_TRANSACAO, NR_CONTA, CD_TIPO, VL_TRANSACAO, DS_TRANSACAO, DT_TRANSACAO)
VALUES ('despesa-002', 'conta-001', 'Despesa', 70.00, 'Transporte', TO_DATE('2025-03-30', 'YYYY-MM-DD'))

INTO T_FIN_TRANSACAO (NR_TRANSACAO, NR_CONTA, CD_TIPO, VL_TRANSACAO, DS_TRANSACAO, DT_TRANSACAO)
VALUES ('despesa-003', 'conta-001', 'Despesa', 45.50, 'Restaurante', TO_DATE('2025-03-29', 'YYYY-MM-DD'))

INTO T_FIN_TRANSACAO (NR_TRANSACAO, NR_CONTA, CD_TIPO, VL_TRANSACAO, DS_TRANSACAO, DT_TRANSACAO)
VALUES ('despesa-004', 'conta-001', 'Despesa', 200.00, 'Internet/Telefone', TO_DATE('2025-03-28', 'YYYY-MM-DD'))

INTO T_FIN_TRANSACAO (NR_TRANSACAO, NR_CONTA, CD_TIPO, VL_TRANSACAO, DS_TRANSACAO, DT_TRANSACAO)
VALUES ('despesa-005', 'conta-001', 'Despesa', 350.00, 'Aluguel', TO_DATE('2025-03-25', 'YYYY-MM-DD'))

SELECT * FROM dual;
--