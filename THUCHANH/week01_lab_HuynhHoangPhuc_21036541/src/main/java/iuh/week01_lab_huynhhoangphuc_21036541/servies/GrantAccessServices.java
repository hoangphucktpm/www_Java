package iuh.week01_lab_huynhhoangphuc_21036541.servies;

import iuh.week01_lab_huynhhoangphuc_21036541.repositories.GrantAccessRepository;

import java.sql.Connection;
import java.sql.SQLException;

public class GrantAccessServices {
    private GrantAccessRepository grantAccessRepository;

    public GrantAccessServices(Connection connection) {
        this.grantAccessRepository = new GrantAccessRepository(connection);
    }

    public void grantAccess(String accountId, String roleId, boolean isGrant, String note) throws SQLException {
        grantAccessRepository.grantAccess(accountId, roleId, isGrant, note);
    }
}