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
        String action = req.getParameter("action");
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is missing.");
            return;
        }

        switch (action.toLowerCase()) {
            case "login":
                handleLogin(req, resp, session);
                break;
            case "editaccount":
                handleEditAccount(req, resp, session);
                break;
            case "addaccount":
                handleAddAccount(req, resp, session);
                break;
            case "logout":
                handleLogout(req, resp, session);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String action = req.getParameter("action");
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is missing.");
            return;
        }

        switch (action.toLowerCase()) {
            case "deleteaccount":
                handleDeleteAccount(req, resp, session);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
                break;
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        String accountID = req.getParameter("accountID");
        String password = req.getParameter("password");

        if (accountID == null || password == null || accountID.trim().isEmpty() || password.trim().isEmpty()) {
            session.setAttribute("loginStatus", "Account ID and password must not be empty.");
            resp.sendRedirect("index.jsp");
            return;
        }

        AccountDao accountDao = new AccountDao();
        Optional<Account> optional = accountDao.kiemTraDangNhap(accountID, password);

        if (optional.isEmpty()) {
            session.setAttribute("loginStatus", "Tài khoản hoặc mật khẩu không đúng.");
            resp.sendRedirect("index.jsp");
        } else {
            session.setAttribute("loginStatus", null);
            session.setAttribute("AccountData", optional.get());
            resp.sendRedirect("dashboard.jsp");
        }
    }

    private void handleEditAccount(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        String accountID = req.getParameter("accountID");
        String password = req.getParameter("password");
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        byte status = Byte.parseByte(req.getParameter("status"));

        Account account = new Account(accountID, password, fullName, email, phone, status);
        AccountDao accountDao = new AccountDao();
        boolean result = accountDao.capNhat(account);

        if (result) {
            session.setAttribute("editStatus", "Cập nhật thông tin tài khoản thành công.");
        } else {
            session.setAttribute("editStatus", "Cập nhật thông tin tài khoản thất bại.");
        }

        resp.sendRedirect("dashboard.jsp");
    }

    private void handleAddAccount(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        String accountID = req.getParameter("accountID");
        String fullName = req.getParameter("fullName");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        byte status = Byte.parseByte(req.getParameter("status"));

        Account account = new Account(accountID, fullName, password, email, phone, status);
        AccountDao accountDao = new AccountDao();
        boolean result = accountDao.them(account);

        if (result) {
            session.setAttribute("addStatus", "Thêm tài khoản thành công.");
        } else {
            session.setAttribute("addStatus", "Thêm tài khoản thất bại.");
        }

        resp.sendRedirect("dashboard.jsp");
    }

    private void handleDeleteAccount(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        String accountID = req.getParameter("accountID");
        Account account = new Account(accountID);

        AccountDao accountDao = new AccountDao();
        boolean result = accountDao.xoa(account);

        if (result) {
            session.setAttribute("deleteStatus", "Xóa tài khoản thành công.");
        } else {
            session.setAttribute("deleteStatus", "Xóa tài khoản thất bại.");
        }

        resp.sendRedirect("dashboard.jsp");
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        session.invalidate();
        System.out.println("Logout successfully.");
        resp.sendRedirect("index.jsp");
    }
}