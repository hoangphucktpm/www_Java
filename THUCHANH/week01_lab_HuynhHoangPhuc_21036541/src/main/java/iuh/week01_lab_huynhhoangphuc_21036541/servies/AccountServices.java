package iuh.week01_lab_huynhhoangphuc_21036541.servies;

import iuh.week01_lab_huynhhoangphuc_21036541.dao.AccountDao;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.Account;

import java.util.List;
import java.util.Optional;

public class AccountServices {
    private AccountDao accountDao;

    public AccountServices() {
        accountDao = new AccountDao();
    }

    public Account layAccount(String userName, String password) throws Exception {
        Optional<Account> optionalAccount = accountDao.layTheoMa(userName, password);
        if (optionalAccount.isPresent()) {
            return optionalAccount.get();
        } else {
            throw new Exception("Account not found for provided credentials.");
        }
    }

    public List<Account> layDanhSachAccount() {
        return accountDao.layDs();
    }
}
