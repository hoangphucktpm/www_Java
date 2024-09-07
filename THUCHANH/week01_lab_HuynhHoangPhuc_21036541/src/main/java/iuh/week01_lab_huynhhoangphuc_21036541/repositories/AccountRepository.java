package iuh.week01_lab_huynhhoangphuc_21036541.repositories;

import iuh.week01_lab_huynhhoangphuc_21036541.entites.Account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AccountRepository {

    private Connection connection;

    public AccountRepository(Connection connection) {
        this.connection = connection;
    }

    public Account getAccount(String accountId) throws SQLException {
        String sql = "SELECT * FROM account WHERE account_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, accountId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Account account = new Account();
                    account.setAccountId(rs.getString("account_id"));
                    account.setFullName(rs.getString("full_name"));
                    account.setPassword(rs.getString("password"));
                    account.setEmail(rs.getString("email"));
                    account.setPhone(rs.getString("phone"));
                    account.setStatus(rs.getByte("status"));
                    return account;
                }
            }
        }
        return null;
    }

    public void addAccount(Account account) throws SQLException {
        String sql = "INSERT INTO account (account_id, full_name, password, email, phone, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, account.getAccountId());
            stmt.setString(2, account.getFullName());
            stmt.setString(3, account.getPassword());
            stmt.setString(4, account.getEmail());
            stmt.setString(5, account.getPhone());
            stmt.setInt(6, account.getStatus());
            stmt.executeUpdate();
        }
    }

    public void updateAccount(Account account) throws SQLException {
        String sql = "UPDATE account SET full_name = ?, password = ?, email = ?, phone = ?, status = ? WHERE account_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, account.getFullName());
            stmt.setString(2, account.getPassword());
            stmt.setString(3, account.getEmail());
            stmt.setString(4, account.getPhone());
            stmt.setInt(5, account.getStatus());
            stmt.setString(6, account.getAccountId());
            stmt.executeUpdate();
        }
    }

    public void deleteAccount(String accountId) throws SQLException {
        String sql = "DELETE FROM account WHERE account_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, accountId);
            stmt.executeUpdate();
        }
    }
}
