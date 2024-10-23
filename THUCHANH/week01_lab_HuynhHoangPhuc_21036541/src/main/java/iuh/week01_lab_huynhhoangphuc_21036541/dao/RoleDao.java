package iuh.week01_lab_huynhhoangphuc_21036541.dao;

import iuh.week01_lab_huynhhoangphuc_21036541.connectDB.ConnectDB;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.GrantAccess;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.Role;
import iuh.week01_lab_huynhhoangphuc_21036541.repositories.IRepository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class RoleDao implements IRepository<Role> {
    private ConnectDB connectDB;

    public RoleDao() {
        connectDB = new ConnectDB();
    }

    @Override
    public boolean them(Role role) {
        return false;
    }

    @Override
    public boolean xoa(Role role) {
        return false;
    }

    @Override
    public boolean capNhat(Role role) {
        return false;
    }

    @Override
    public List<Role> layDs() {
        try {
            List<Role> list = new ArrayList<>();
            Statement statement = connectDB.getConnection().createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM role");
            while (resultSet.next()) {
                Role role = new Role(resultSet.getString(1), resultSet.getString(2), resultSet.getString(3), resultSet.getByte(4));
                list.add(role);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Optional<Role> layTheoMa(Object... objects) {
        if (objects.length > 0 && objects[0] instanceof String) {
            String roleId = (String) objects[0];
            try {
                PreparedStatement preparedStatement = connectDB.getConnection().prepareStatement("SELECT * FROM role WHERE role_id = ?");
                preparedStatement.setString(1, roleId);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    Role role = new Role(resultSet.getString(1), resultSet.getString(2), resultSet.getString(3), resultSet.getByte(4));
                    return Optional.of(role);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return Optional.empty();
    }


    @Override
    public List<Role> layDanhSachRoleByAccount(String accountId) {
        List<Role> roles = new ArrayList<>();
        try {
            String query = "SELECT r.role_id, r.role_name, r.description, r.status " +
                    "FROM role r " +
                    "JOIN grant_access ga ON r.role_id = ga.role_id " +
                    "WHERE ga.account_id = ?";
            PreparedStatement preparedStatement = connectDB.getConnection().prepareStatement(query);
            preparedStatement.setString(1, accountId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Role role = new Role(resultSet.getString(1), resultSet.getString(2), resultSet.getString(3), resultSet.getByte(4));
                roles.add(role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roles;
    }

    @Override
    public List<GrantAccess> layDanhSachGrantAccessByAccount(String accountId) {
        return List.of();
    }
}