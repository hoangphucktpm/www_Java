package iuh.week01_lab_huynhhoangphuc_21036541.servies;

import iuh.week01_lab_huynhhoangphuc_21036541.repositories.LogRepository;

import java.sql.Connection;
import java.sql.SQLException;

public class LogServices {
    private LogRepository logRepository;

    public LogServices(Connection connection) {
        this.logRepository = new LogRepository(connection);
    }

    public void logLogin(String accountId) throws SQLException {
        logRepository.logLogin(accountId);
    }

    public void logLogout(String accountId) throws SQLException {
        logRepository.logLogout(accountId);
    }
}
