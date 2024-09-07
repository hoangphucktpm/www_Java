package iuh.week01_lab_huynhhoangphuc_21036541.repositories;


import iuh.week01_lab_huynhhoangphuc_21036541.entites.Role;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RoleRepository {

    private Connection connection;

    public RoleRepository(Connection connection) {
        this.connection = connection;
    }

    public Role getRole(String roleId) throws SQLException {
        String sql = "SELECT * FROM role WHERE role_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, roleId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role();
                    role.setRoleId(rs.getString("role_id"));
                    role.setRoleName(rs.getString("role_name"));
                    role.setDescription(rs.getString("description"));
                    role.setStatus(rs.getByte("status"));
                    return role;
                }
            }
        }
        return null;
    }

    public void addRole(Role role) throws SQLException {
        String sql = "INSERT INTO role (role_id, role_name, description, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, role.getRoleId());
            stmt.setString(2, role.getRoleName());
            stmt.setString(3, role.getDescription());
            stmt.setInt(4, role.getStatus());
            stmt.executeUpdate();
        }
    }

    public void updateRole(Role role) throws SQLException {
        String sql = "UPDATE role SET role_name = ?, description = ?, status = ? WHERE role_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, role.getRoleName());
            stmt.setString(2, role.getDescription());
            stmt.setInt(3, role.getStatus());
            stmt.setString(4, role.getRoleId());
            stmt.executeUpdate();
        }
    }

    public void deleteRole(String roleId) throws SQLException {
        String sql = "DELETE FROM role WHERE role_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, roleId);
            stmt.executeUpdate();
        }
    }
}
