package iuh.week01_lab_huynhhoangphuc_21036541.servies;

import iuh.week01_lab_huynhhoangphuc_21036541.entites.Account;
import iuh.week01_lab_huynhhoangphuc_21036541.repositories.AccountRepository;

import java.sql.Connection;
import java.sql.SQLException;

public class AccountServices {

    private AccountRepository accountRepository;

    public AccountServices(Connection connection) {
        this.accountRepository = new AccountRepository(connection);
    }

    public Account getAccount(String accountId) throws SQLException {
        return accountRepository.getAccount(accountId);
    }

    public void addAccount(Account account) throws SQLException {
        accountRepository.addAccount(account);
    }

    public void updateAccount(Account account) throws SQLException {
        accountRepository.updateAccount(account);
    }

    public void deleteAccount(String accountId) throws SQLException {
        accountRepository.deleteAccount(accountId);
    }
}
