package iuh.week01_lab_huynhhoangphuc_21036541.controllers;

import iuh.week01_lab_huynhhoangphuc_21036541.dao.AccountDao;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.Account;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "ControlServlet", value = "/control-servlet")
public class ControllerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String getAction = (String) session.getAttribute("action");


        if ("login".equalsIgnoreCase(getAction)) {
            String accountID = req.getParameter("accountID");
            String password = req.getParameter("password");

            System.out.println("Account ID: " + accountID);
            System.out.println("Password: " + password);

            if (accountID == null || password == null || accountID.trim().isEmpty() || password.trim().isEmpty()) {
                session.setAttribute("loginStatus", "Account ID and password must not be empty.");
                resp.sendRedirect("index.jsp");
                return;
            }

            AccountDao accountDao = new AccountDao();
            Optional<Account> optional = accountDao.kiemTraDangNhap(accountID, password);

            if (optional.isEmpty()) {
                session.setAttribute("loginStatus", "Invalid Account ID or Password.");
                resp.sendRedirect("index.jsp");
            } else {
                session.setAttribute("loginStatus", null);
                session.setAttribute("AccountData", optional.get());
                resp.sendRedirect("dashboard.jsp");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
    }
}
