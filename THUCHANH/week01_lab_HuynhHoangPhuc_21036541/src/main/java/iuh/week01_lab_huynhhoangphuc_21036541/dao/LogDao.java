package iuh.week01_lab_huynhhoangphuc_21036541.dao;

import iuh.week01_lab_huynhhoangphuc_21036541.connectDB.ConnectDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LogDao {

    public void logLogin(String accountId, String note) {
        String query = "INSERT INTO log (account_id, notes) VALUES (?, ?)";
        try (Connection connection = new ConnectDB().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, accountId);
            preparedStatement.setString(2, note);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void logLogout(String accountId) {
        String query = "UPDATE log SET logout_time = CURRENT_TIMESTAMP WHERE account_id = ? ORDER BY login_time DESC LIMIT 1";
        try (Connection connection = new ConnectDB().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, accountId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void fetchLogs() {
        String query = "SELECT * FROM log";
        try (Connection connection = new ConnectDB().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                System.out.println("Log ID: " + resultSet.getLong("id"));
                System.out.println("Account ID: " + resultSet.getString("account_id"));
                System.out.println("Login Time: " + resultSet.getTimestamp("login_time"));
                System.out.println("Logout Time: " + resultSet.getTimestamp("logout_time"));
                System.out.println("Notes: " + resultSet.getString("notes"));
                System.out.println("====================================");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
