package iuh.week01_lab_huynhhoangphuc_21036541.servies;

import iuh.week01_lab_huynhhoangphuc_21036541.entites.Role;
import iuh.week01_lab_huynhhoangphuc_21036541.repositories.RoleRepository;

import java.sql.Connection;
import java.sql.SQLException;

public class RoleServices {

    private RoleRepository roleRepository;

    public RoleServices(Connection connection) {
        this.roleRepository = new RoleRepository(connection);
    }

    public Role getRole(String roleId) throws SQLException {
        return roleRepository.getRole(roleId);
    }

    public void addRole(Role role) throws SQLException {
        roleRepository.addRole(role);
    }

    public void updateRole(Role role) throws SQLException {
        roleRepository.updateRole(role);
    }

    public void deleteRole(String roleId) throws SQLException {
        roleRepository.deleteRole(roleId);
    }
}