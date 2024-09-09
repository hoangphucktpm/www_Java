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

public class AccountDao implements IRepository<Account> {
    @Inject
    private ConnectDB connectDB;

    public AccountDao() {
        connectDB = new ConnectDB();
    }

    @Override
    public boolean them(Account account) {
        try {
            // Ensure the connection uses UTF-8 encoding
            String query = "INSERT INTO account (account_id, full_name, password, email, phone, status) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connectDB.getConnection().prepareStatement(query);
            preparedStatement.setString(1, account.getAccountId());
            preparedStatement.setString(2, account.getFullName());
            preparedStatement.setString(3, account.getPassword());
            preparedStatement.setString(4, account.getEmail());
            preparedStatement.setString(5, account.getPhone());
            preparedStatement.setByte(6, account.getStatus());
            int rowsInserted = preparedStatement.executeUpdate();
            return rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean xoa(Account account) {
        try {
            String query = "DELETE FROM account WHERE account_id = ?";
            PreparedStatement preparedStatement = connectDB.getConnection().prepareStatement(query);
            preparedStatement.setString(1, account.getAccountId());
            int rowsDeleted = preparedStatement.executeUpdate();
            return rowsDeleted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean capNhat(Account account) {
        try {
            String query = "UPDATE account SET password = ?, full_name = ?, email = ?, phone = ?, status = ? WHERE account_id = ?";
            PreparedStatement preparedStatement = connectDB.getConnection().prepareStatement(query);
            preparedStatement.setString(1, account.getPassword());
            preparedStatement.setString(2, account.getFullName());
            preparedStatement.setString(3, account.getEmail());
            preparedStatement.setString(4, account.getPhone());
            preparedStatement.setByte(5, account.getStatus());
            preparedStatement.setString(6, account.getAccountId());
            int rowsUpdated = preparedStatement.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Account> layDs() {
        List<Account> list = new ArrayList<>();
        try (Statement statement = connectDB.getConnection().createStatement();
             ResultSet resultSet = statement.executeQuery("SELECT * FROM account")) {
            while (resultSet.next()) {
                Account account = new Account(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getByte(6)
                );
                list.add(account);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Optional<Account> layTheoMa(Object... objects) {
        if (objects.length > 0 && objects[0] != null) {
            try (PreparedStatement preparedStatement = connectDB.getConnection()
                    .prepareStatement("SELECT * FROM account WHERE account_id = ?")) {
                preparedStatement.setString(1, objects[0].toString());
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        Account account = new Account(
                                resultSet.getString(1),
                                resultSet.getString(2),
                                resultSet.getString(3),
                                resultSet.getString(4),
                                resultSet.getString(5),
                                resultSet.getByte(6)
                        );
                        return Optional.of(account);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return Optional.empty();
    }

    @Override
    public List<Role> layDanhSachRoleByAccount(String accountId) {
        return List.of();
    }

    @Override
    public List<GrantAccess> layDanhSachGrantAccessByAccount(String accountId) {
        return List.of();
    }

    public Optional<Account> kiemTraDangNhap(String userName, String password) {
        try (PreparedStatement preparedStatement = connectDB.getConnection()
                .prepareStatement("SELECT * FROM account WHERE account_id = ? AND password = ?")) {
            preparedStatement.setString(1, userName);
            preparedStatement.setString(2, password);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    Account account = new Account(
                            resultSet.getString(1),
                            resultSet.getString(2),
                            resultSet.getString(3),
                            resultSet.getString(4),
                            resultSet.getString(5),
                            resultSet.getByte(6)
                    );
                    return Optional.of(account);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
