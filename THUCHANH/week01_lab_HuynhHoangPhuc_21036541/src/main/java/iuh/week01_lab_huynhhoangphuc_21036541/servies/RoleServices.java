package iuh.week01_lab_huynhhoangphuc_21036541.servies;

import iuh.week01_lab_huynhhoangphuc_21036541.dao.RoleDao;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.Role;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class RoleServices {
    private RoleDao roleDao;
    public RoleServices(){
        roleDao = new RoleDao();
    }
    public List<Role> layDanhSachRole(){
        return roleDao.layDs();
    }
    public List<Role> layDanhSachRoleByAccount(String accountId){
        return roleDao.layDanhSachRoleByAccount(accountId);
    }
}