package iuh.week01_lab_huynhhoangphuc_21036541.servies;

import iuh.week01_lab_huynhhoangphuc_21036541.dao.GrantAccessDao;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.GrantAccess;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class GrantAccessServices {
    private GrantAccessDao grantAccessDao;
    public GrantAccessServices(){
        grantAccessDao = new GrantAccessDao();
    }
    public List<GrantAccess> layDanhSachGrantAccess(){
        return grantAccessDao.layDs();
    }
    public List<GrantAccess> layDanhSachGrantAccessByAccount(String accountId){
        return grantAccessDao.layDanhSachGrantAccessByAccount(accountId);
    }
}