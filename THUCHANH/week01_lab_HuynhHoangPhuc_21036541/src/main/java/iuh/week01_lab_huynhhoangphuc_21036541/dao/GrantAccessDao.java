package iuh.week01_lab_huynhhoangphuc_21036541.dao;

import iuh.week01_lab_huynhhoangphuc_21036541.connectDB.ConnectDB;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.Account;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.GrantAccess;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.Role;
import iuh.week01_lab_huynhhoangphuc_21036541.repositories.IRepository;
import jakarta.inject.Inject;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class GrantAccessDao implements IRepository<GrantAccess> {
    @Inject
    private ConnectDB connectDB;

    public GrantAccessDao(){
        connectDB = new ConnectDB();
    }
    @Override
    public boolean them(GrantAccess grantAccess) {
        return false;
    }

    @Override
    public boolean xoa(GrantAccess grantAccess) {
        return false;
    }

    @Override
    public boolean capNhat(GrantAccess grantAccess) {
        return false;
    }

    @Override
    public List<GrantAccess> layDs() {
        List<GrantAccess> list = new ArrayList<>();
        try {
            Statement statement = connectDB.getConnection().createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM grant_access");

            while (resultSet.next()) {
                // Lấy Account
                Optional<Account> optionalAccount = new AccountDao().layTheoMa(resultSet.getString(1));
                if (!optionalAccount.isPresent()) {
                    System.out.println("Không tìm thấy Account với ID: " + resultSet.getString(1));
                    continue;
                }
                Account account = optionalAccount.get();

                // Lấy Role
                Optional<Role> optionalRole = new RoleDao().layTheoMa(resultSet.getString(2));
                if (!optionalRole.isPresent()) {
                    System.out.println("Không tìm thấy Role với ID: " + resultSet.getString(2));
                    continue;
                }
                Role role = optionalRole.get();

                // Tạo đối tượng GrantAccess
                GrantAccess grantAccess = new GrantAccess(
                        account,
                        role,
                        resultSet.getInt(3) == 1, // true nếu giá trị bằng 1
                        resultSet.getString(4) == null ? null : resultSet.getString(4) // Xử lý giá trị null
                );

                // Thêm vào danh sách
                list.add(grantAccess);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    @Override
    public Optional<GrantAccess> layTheoMa(Object... objects) throws Exception {
        return Optional.empty();
    }
}
