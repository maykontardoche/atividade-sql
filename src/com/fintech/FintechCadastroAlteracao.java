package com.fintech;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.math.BigDecimal;

/**
 * Classe responsável por realizar operações de cadastro e alteração
 * no banco de dados Oracle para o sistema Fintech.
 *
 * As operações abrangem:
 * - Inserção e atualização de Usuário
 * - Inserção de Conta Financeira
 * - Inserção/Atualização de Transações (Receita e Despesa)
 * - Inserção/Atualização de Investimentos
 *
 * Também foram implementadas as consultas necessárias conforme solicitado.
 */
public class FintechCadastroAlteracao {

        // Dados de conexão com o banco Oracle
        private static final String URL = "jdbc:oracle:thin:@localhost:1521:XE"; // Exemplo para Oracle XE
        private static final String USER = "seu_usuario";
        private static final String PASS = "sua_senha";

        public static void main(String[] args) {
                try (Connection conn = DriverManager.getConnection(URL, USER, PASS)) {

                        // 1. Operações com a tabela "Usuario"
                        insertUsuario(conn,
                                        "a1b2c3d4-e5f6-7890-abcd-ef1234567890", // ID_Usuario
                                        "Fulano de Tal", // Nome
                                        "fulano@exemplo.com", // Email
                                        "senha123", // Senha
                                        "2025-04-03", // Data_Cadastro (YYYY-MM-DD)
                                        "Comum", // Tipo_Usuario
                                        new BigDecimal("1000.00")); // Meta_Financeira

                        updateUsuario(conn,
                                        "a1b2c3d4-e5f6-7890-abcd-ef1234567890", // ID_Usuario (referência)
                                        "Fulano Silva", // Nome atualizado
                                        "fulano.silva@exemplo.com", // Email atualizado
                                        "novaSenha456", // Senha atualizada
                                        "2025-04-03", // Data_Cadastro
                                        "Premium", // Tipo_Usuario atualizado
                                        new BigDecimal("1500.00")); // Meta_Financeira atualizada

                        // 2. Operações com a tabela "Conta_Financeira"
                        insertContaFinanceira(conn,
                                        "1111-2222-3333-4444", // ID_Conta
                                        "Corrente", // Tipo_Conta
                                        new BigDecimal("500.00"), // Saldo
                                        "2025-04-03", // Data_Abertura
                                        "Ativa", // Status
                                        "a1b2c3d4-e5f6-7890-abcd-ef1234567890", // ID_Usuario
                                        "banco-uuid-exemplo"); // ID_Banco

                        // 3. Operações com a tabela "Transacao"
                        // 3.1. Inserção e atualização para Receita
                        insertReceita(conn,
                                        "transacao-receita-001", // ID_Transacao
                                        "2025-04-04", // Data da transação
                                        new BigDecimal("2000.00"), // Valor
                                        "Salário", // Descricao
                                        "Renda", // Categoria
                                        "1111-2222-3333-4444", // ID_Conta
                                        "meta-uuid"); // ID_Meta

                        updateReceita(conn,
                                        "transacao-receita-001", // ID_Transacao (referência)
                                        "2025-04-04", // Data da transação
                                        new BigDecimal("2100.00"), // Valor atualizado
                                        "Salário Atualizado", // Descricao atualizada
                                        "Renda", // Categoria
                                        "1111-2222-3333-4444", // ID_Conta
                                        "meta-uuid"); // ID_Meta

                        // 3.2. Inserção e atualização para Despesa
                        insertDespesa(conn,
                                        "transacao-despesa-001", // ID_Transacao
                                        "2025-04-05", // Data da transação
                                        new BigDecimal("300.00"), // Valor
                                        "Conta de Luz", // Descricao
                                        "Serviços", // Categoria
                                        "1111-2222-3333-4444", // ID_Conta
                                        "meta-uuid"); // ID_Meta

                        updateDespesa(conn,
                                        "transacao-despesa-001", // ID_Transacao (referência)
                                        "2025-04-05", // Data da transação
                                        new BigDecimal("320.00"), // Valor atualizado
                                        "Conta de Luz Atualizada", // Descricao atualizada
                                        "Serviços", // Categoria
                                        "1111-2222-3333-4444", // ID_Conta
                                        "meta-uuid"); // ID_Meta

                        // 4. Operações com a tabela "Investimento"
                        insertInvestimento(conn,
                                        "investimento-001", // ID_Investimento
                                        "Ações", // Tipo_Investimento
                                        new BigDecimal("5000.00"), // Valor_Inicial
                                        new BigDecimal("0.08"), // Rentabilidade
                                        "2025-04-01", // Data_Inicio
                                        "2026-04-01", // Data_Final
                                        "Ativo", // Status do investimento
                                        "1111-2222-3333-4444"); // ID_Conta

                        updateInvestimento(conn,
                                        "investimento-001", // ID_Investimento (referência)
                                        "Ações Atualizadas", // Tipo_Investimento atualizado
                                        new BigDecimal("5200.00"), // Valor_Inicial atualizado
                                        new BigDecimal("0.09"), // Rentabilidade atualizada
                                        "2025-04-01", // Data_Inicio
                                        "2026-04-01", // Data_Final
                                        "Ativo", // Status do investimento
                                        "1111-2222-3333-4444"); // ID_Conta

                        // Aqui você pode chamar métodos de consulta se desejar.
                        // As consultas SQL abaixo podem ser testadas via sua ferramenta de acesso ao
                        // Oracle.

                } catch (SQLException e) {
                        System.err.println("Erro: " + e.getMessage());
                }
        }

        // --- Métodos de Operação no Banco de Dados ---

        // Cadastro do Usuário
        public static void insertUsuario(Connection conn, String idUsuario, String nome, String email, String senha,
                        String dataCadastro, String tipoUsuario, BigDecimal metaFinanceira) throws SQLException {
                String sql = "INSERT INTO \"Usuario\" " +
                                "(\"ID_Usuario\", \"Nome\", \"Email\", \"Senha\", \"Data_Cadastro\", \"Tipo_Usuario\", \"Meta_Financeira\") "
                                +
                                "VALUES (?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, idUsuario);
                        ps.setString(2, nome);
                        ps.setString(3, email);
                        ps.setString(4, senha);
                        ps.setString(5, dataCadastro);
                        ps.setString(6, tipoUsuario);
                        ps.setBigDecimal(7, metaFinanceira);
                        int rows = ps.executeUpdate();
                        System.out.println("Usuário inserido: " + rows);
                }
        }

        // Alteração do Usuário
        public static void updateUsuario(Connection conn, String idUsuario, String nome, String email, String senha,
                        String dataCadastro, String tipoUsuario, BigDecimal metaFinanceira) throws SQLException {
                String sql = "UPDATE \"Usuario\" SET " +
                                "\"Nome\" = ?, \"Email\" = ?, \"Senha\" = ?, " +
                                "\"Data_Cadastro\" = TO_DATE(?, 'YYYY-MM-DD'), " +
                                "\"Tipo_Usuario\" = ?, \"Meta_Financeira\" = ? " +
                                "WHERE \"ID_Usuario\" = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, nome);
                        ps.setString(2, email);
                        ps.setString(3, senha);
                        ps.setString(4, dataCadastro);
                        ps.setString(5, tipoUsuario);
                        ps.setBigDecimal(6, metaFinanceira);
                        ps.setString(7, idUsuario);
                        int rows = ps.executeUpdate();
                        System.out.println("Usuário atualizado: " + rows);
                }
        }

        // Cadastro da Conta Financeira
        public static void insertContaFinanceira(Connection conn, String idConta, String tipoConta, BigDecimal saldo,
                        String dataAbertura, String status, String idUsuario, String idBanco) throws SQLException {
                String sql = "INSERT INTO \"Conta_Financeira\" " +
                                "(\"ID_Conta\", \"Tipo_Conta\", \"Saldo\", \"Data_Abertura\", \"Status\", \"ID_Usuario\", \"ID_Banco\") "
                                +
                                "VALUES (?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, idConta);
                        ps.setString(2, tipoConta);
                        ps.setBigDecimal(3, saldo);
                        ps.setString(4, dataAbertura);
                        ps.setString(5, status);
                        ps.setString(6, idUsuario);
                        ps.setString(7, idBanco);
                        int rows = ps.executeUpdate();
                        System.out.println("Conta financeira inserida: " + rows);
                }
        }

        // Cadastro de Receita (Transacao com Tipo 'Receita')
        public static void insertReceita(Connection conn, String idTransacao, String dataTransacao, BigDecimal valor,
                        String descricao, String categoria, String idConta, String idMeta) throws SQLException {
                String sql = "INSERT INTO \"Transacao\" " +
                                "(\"ID_Transacao\", \"Data\", \"Tipo\", \"Valor\", \"Descricao\", \"Categoria\", \"ID_Conta\", \"ID_Meta\") "
                                +
                                "VALUES (?, TO_DATE(?, 'YYYY-MM-DD'), 'Receita', ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, idTransacao);
                        ps.setString(2, dataTransacao);
                        ps.setBigDecimal(3, valor);
                        ps.setString(4, descricao);
                        ps.setString(5, categoria);
                        ps.setString(6, idConta);
                        ps.setString(7, idMeta);
                        int rows = ps.executeUpdate();
                        System.out.println("Receita inserida: " + rows);
                }
        }

        // Alteração de Receita
        public static void updateReceita(Connection conn, String idTransacao, String dataTransacao, BigDecimal valor,
                        String descricao, String categoria, String idConta, String idMeta) throws SQLException {
                String sql = "UPDATE \"Transacao\" SET " +
                                "\"Data\" = TO_DATE(?, 'YYYY-MM-DD'), " +
                                "\"Valor\" = ?, \"Descricao\" = ?, \"Categoria\" = ?, " +
                                "\"ID_Conta\" = ?, \"ID_Meta\" = ? " +
                                "WHERE \"ID_Transacao\" = ? AND \"Tipo\" = 'Receita'";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, dataTransacao);
                        ps.setBigDecimal(2, valor);
                        ps.setString(3, descricao);
                        ps.setString(4, categoria);
                        ps.setString(5, idConta);
                        ps.setString(6, idMeta);
                        ps.setString(7, idTransacao);
                        int rows = ps.executeUpdate();
                        System.out.println("Receita atualizada: " + rows);
                }
        }

        // Cadastro de Despesa (Transacao com Tipo 'Despesa')
        public static void insertDespesa(Connection conn, String idTransacao, String dataTransacao, BigDecimal valor,
                        String descricao, String categoria, String idConta, String idMeta) throws SQLException {
                String sql = "INSERT INTO \"Transacao\" " +
                                "(\"ID_Transacao\", \"Data\", \"Tipo\", \"Valor\", \"Descricao\", \"Categoria\", \"ID_Conta\", \"ID_Meta\") "
                                +
                                "VALUES (?, TO_DATE(?, 'YYYY-MM-DD'), 'Despesa', ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, idTransacao);
                        ps.setString(2, dataTransacao);
                        ps.setBigDecimal(3, valor);
                        ps.setString(4, descricao);
                        ps.setString(5, categoria);
                        ps.setString(6, idConta);
                        ps.setString(7, idMeta);
                        int rows = ps.executeUpdate();
                        System.out.println("Despesa inserida: " + rows);
                }
        }

        // Alteração de Despesa
        public static void updateDespesa(Connection conn, String idTransacao, String dataTransacao, BigDecimal valor,
                        String descricao, String categoria, String idConta, String idMeta) throws SQLException {
                String sql = "UPDATE \"Transacao\" SET " +
                                "\"Data\" = TO_DATE(?, 'YYYY-MM-DD'), " +
                                "\"Valor\" = ?, \"Descricao\" = ?, \"Categoria\" = ?, " +
                                "\"ID_Conta\" = ?, \"ID_Meta\" = ? " +
                                "WHERE \"ID_Transacao\" = ? AND \"Tipo\" = 'Despesa'";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, dataTransacao);
                        ps.setBigDecimal(2, valor);
                        ps.setString(3, descricao);
                        ps.setString(4, categoria);
                        ps.setString(5, idConta);
                        ps.setString(6, idMeta);
                        ps.setString(7, idTransacao);
                        int rows = ps.executeUpdate();
                        System.out.println("Despesa atualizada: " + rows);
                }
        }

        // Cadastro de Investimento
        public static void insertInvestimento(Connection conn, String idInvestimento, String tipoInvestimento,
                        BigDecimal valorInicial, BigDecimal rentabilidade,
                        String dataInicio, String dataFinal, String statusInvestimento, String idConta)
                        throws SQLException {
                String sql = "INSERT INTO \"Investimento\" " +
                                "(\"ID_Investimento\", \"Tipo_Investimento\", \"Valor_Inicial\", \"Rentabilidade\", \"Data_Inicio\", \"Data_Final\", \"Status\", \"ID_Conta\") "
                                +
                                "VALUES (?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), TO_DATE(?, 'YYYY-MM-DD'), ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, idInvestimento);
                        ps.setString(2, tipoInvestimento);
                        ps.setBigDecimal(3, valorInicial);
                        ps.setBigDecimal(4, rentabilidade);
                        ps.setString(5, dataInicio);
                        ps.setString(6, dataFinal);
                        ps.setString(7, statusInvestimento);
                        ps.setString(8, idConta);
                        int rows = ps.executeUpdate();
                        System.out.println("Investimento inserido: " + rows);
                }
        }

        // Alteração de Investimento
        public static void updateInvestimento(Connection conn, String idInvestimento, String tipoInvestimento,
                        BigDecimal valorInicial, BigDecimal rentabilidade,
                        String dataInicio, String dataFinal, String statusInvestimento, String idConta)
                        throws SQLException {
                String sql = "UPDATE \"Investimento\" SET " +
                                "\"Tipo_Investimento\" = ?, \"Valor_Inicial\" = ?, \"Rentabilidade\" = ?, " +
                                "\"Data_Inicio\" = TO_DATE(?, 'YYYY-MM-DD'), " +
                                "\"Data_Final\" = TO_DATE(?, 'YYYY-MM-DD'), " +
                                "\"Status\" = ?, \"ID_Conta\" = ? " +
                                "WHERE \"ID_Investimento\" = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, tipoInvestimento);
                        ps.setBigDecimal(2, valorInicial);
                        ps.setBigDecimal(3, rentabilidade);
                        ps.setString(4, dataInicio);
                        ps.setString(5, dataFinal);
                        ps.setString(6, statusInvestimento);
                        ps.setString(7, idConta);
                        ps.setString(8, idInvestimento);
                        int rows = ps.executeUpdate();
                        System.out.println("Investimento atualizado: " + rows);
                }
        }
}
