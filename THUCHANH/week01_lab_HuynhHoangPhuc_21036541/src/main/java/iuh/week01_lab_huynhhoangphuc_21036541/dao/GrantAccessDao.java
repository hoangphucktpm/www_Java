package iuh.week01_lab_huynhhoangphuc_21036541.dao;

import iuh.week01_lab_huynhhoangphuc_21036541.connectDB.ConnectDB;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.Account;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.GrantAccess;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.Role;
import iuh.week01_lab_huynhhoangphuc_21036541.repositories.IRepository;
import jakarta.inject.Inject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class GrantAccessDao implements IRepository<GrantAccess> {
    @Inject
    private ConnectDB connectDB;

    public GrantAccessDao() {
        connectDB = new ConnectDB();
    }

    @Override
    public boolean them(GrantAccess grantAccess) {
        String query = "INSERT INTO grant_access (account_id, role_id, is_grant, note) VALUES (?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connectDB.getConnection().prepareStatement(query)) {
            preparedStatement.setString(1, grantAccess.getAccount().getAccountId());
            preparedStatement.setString(2, grantAccess.getRole().getRoleId());
            preparedStatement.setBoolean(3, grantAccess.getIsGrant());
            preparedStatement.setString(4, grantAccess.getNote());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }



    @Override
    public boolean xoa(GrantAccess grantAccess) {
        // Implement the method to delete a GrantAccess
        return false;
    }

    @Override
    public boolean capNhat(GrantAccess grantAccess) {
        // Implement the method to update a GrantAccess
        return false;
    }

    @Override
    public List<GrantAccess> layDs() {
        List<GrantAccess> list = new ArrayList<>();
        try {
            Statement statement = connectDB.getConnection().createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM grant_access");

            while (resultSet.next()) {
                Optional<Account> optionalAccount = new AccountDao().layTheoMa(resultSet.getString("account_id"));
                if (optionalAccount.isEmpty()) {
                    System.out.println("Không tìm thấy Account với ID: " + resultSet.getString("account_id"));
                    continue;
                }
                Account account = optionalAccount.get();

                Optional<Role> optionalRole = new RoleDao().layTheoMa(resultSet.getString("role_id"));
                if (optionalRole.isEmpty()) {
                    System.out.println("Không tìm thấy Role với ID: " + resultSet.getString("role_id"));
                    continue;
                }
                Role role = optionalRole.get();

                GrantAccess grantAccess = new GrantAccess(
                        account,
                        role,
                        resultSet.getInt("is_grant") == 1,
                        resultSet.getString("note")
                );

                list.add(grantAccess);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<GrantAccess> layDanhSachGrantAccessByAccount(String accountId) {
        List<GrantAccess> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM grant_access WHERE account_id = ?";
            PreparedStatement preparedStatement = connectDB.getConnection().prepareStatement(query);
            preparedStatement.setString(1, accountId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Optional<Account> optionalAccount = new AccountDao().layTheoMa(resultSet.getString("account_id"));
                if (optionalAccount.isEmpty()) {
                    System.out.println("Không tìm thấy Account với ID: " + resultSet.getString("account_id"));
                    continue;
                }
                Account account = optionalAccount.get();

                Optional<Role> optionalRole = new RoleDao().layTheoMa(resultSet.getString("role_id"));
                if (optionalRole.isEmpty()) {
                    System.out.println("Không tìm thấy Role với ID: " + resultSet.getString("role_id"));
                    continue;
                }
                Role role = optionalRole.get();

                GrantAccess grantAccess = new GrantAccess(
                        account,
                        role,
                        resultSet.getInt("is_active") == 1,
                        resultSet.getString("description")
                );

                list.add(grantAccess);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Optional<GrantAccess> layTheoMa(Object... objects) throws Exception {
        // Implement the method to get a GrantAccess by its ID
        return Optional.empty();
    }

    @Override
    public List<Role> layDanhSachRoleByAccount(String accountId) {
        List<Role> roles = new ArrayList<>();
        try {
            String query = "SELECT role_id FROM grant_access WHERE account_id = ?";
            PreparedStatement preparedStatement = connectDB.getConnection().prepareStatement(query);
            preparedStatement.setString(1, accountId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Optional<Role> optionalRole = new RoleDao().layTheoMa(resultSet.getString("role_id"));
                optionalRole.ifPresent(roles::add);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roles;
    }



}