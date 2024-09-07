package iuh.week01_lab_huynhhoangphuc_21036541.repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class LogRepository {

    private Connection connection;

    public LogRepository(Connection connection) {
        this.connection = connection;
    }

    public void logLogin(String accountId) throws SQLException {
        String sql = "INSERT INTO log (account_id, login_time, logout_time, notes) VALUES (?, NOW(), NOW(), '')";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, accountId);
            stmt.executeUpdate();
        }
    }

    public void logLogout(String accountId) throws SQLException {
        String sql = "UPDATE log SET logout_time = NOW() WHERE account_id = ? AND logout_time = login_time";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, accountId);
            stmt.executeUpdate();
        }
    }
}