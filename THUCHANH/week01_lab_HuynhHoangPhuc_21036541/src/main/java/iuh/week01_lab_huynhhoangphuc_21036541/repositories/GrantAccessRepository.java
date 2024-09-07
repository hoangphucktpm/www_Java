package iuh.week01_lab_huynhhoangphuc_21036541.repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GrantAccessRepository {

    private Connection connection;

    public GrantAccessRepository(Connection connection) {
        this.connection = connection;
    }

    public void grantAccess(String accountId, String roleId, boolean isGrant, String note) throws SQLException {
        String sql = "INSERT INTO grant_access (account_id, role_id, is_grant, note) VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE is_grant = VALUES(is_grant), note = VALUES(note)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, accountId);
            stmt.setString(2, roleId);
            stmt.setBoolean(3, isGrant);
            stmt.setString(4, note);
            stmt.executeUpdate();
        }
    }
}
