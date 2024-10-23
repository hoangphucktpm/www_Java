package iuh.week01_lab_huynhhoangphuc_21036541.controllers;

import iuh.week01_lab_huynhhoangphuc_21036541.dao.AccountDao;
import iuh.week01_lab_huynhhoangphuc_21036541.dao.GrantAccessDao;
import iuh.week01_lab_huynhhoangphuc_21036541.dao.LogDao;
import iuh.week01_lab_huynhhoangphuc_21036541.dao.RoleDao;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.Account;

import iuh.week01_lab_huynhhoangphuc_21036541.entites.GrantAccess;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.GrantAccessId;
import iuh.week01_lab_huynhhoangphuc_21036541.entites.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@WebServlet(name = "ControlServlet", value = "/control-servlet")
public class ControllerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String action = req.getParameter("action");
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        System.out.println("Action: " + action);

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
            case "addgrantaccess":
                handleAddGrantAccess(req, resp, session);
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

        System.out.println("Action: " + action);

        switch (action.toLowerCase()) {
            case "deleteaccount":
                handleDeleteAccount(req, resp, session);
                break;
            case "deletegrantaccess":
                handleDeleteGrantAccess(req, resp, session);
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
            session.setAttribute("addStatus", "Tài khoản hoặc mật khẩu không đúng.");
            resp.sendRedirect("index.jsp");
        } else {
            session.setAttribute("addStatus", null);
            session.setAttribute("AccountData", optional.get());

            LogDao logDao = new LogDao();
            logDao.logLogin(accountID, "");
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
            session.setAttribute("addStatus", "Cập nhật thông tin tài khoản thành công.");
        } else {
            session.setAttribute("addStatus", "Cập nhật thông tin tài khoản thất bại.");
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

        AccountDao accountDaoCheck = new AccountDao();
        Optional<Account> optional = accountDaoCheck.layTheoMa(accountID);
        if (optional.isPresent()) {
            session.setAttribute("addStatus", "Tài khoản đã tồn tại.");
            resp.sendRedirect("dashboard.jsp");
            return;
        }

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

    private void handleAddGrantAccess(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        String accountID = req.getParameter("accountID");
        String[] roleIDs = req.getParameterValues("roleIDs[]");

        if (accountID == null || roleIDs == null || accountID.trim().isEmpty()) {
            session.setAttribute("addStatus", "Account ID and Role IDs must not be empty.");
            resp.sendRedirect("dashboard.jsp");
            return;
        }

        GrantAccessDao grantAccessDao = new GrantAccessDao();
        List<GrantAccess> existingGrantAccesses = grantAccessDao.layDanhSachGrantAccessByAccount(accountID);

        boolean accessGranted = false;

        for (String roleID : roleIDs) {
            if (roleID == null || roleID.trim().isEmpty()) {
                continue;
            }

            boolean exists = existingGrantAccesses.stream()
                    .anyMatch(grantAccess -> grantAccess.getId().getAccountId().equals(accountID) &&
                            grantAccess.getId().getRoleId().equals(roleID));

            if (!exists) {
                GrantAccess grantAccess = new GrantAccess();
                GrantAccessId grantAccessId = new GrantAccessId(accountID, roleID);
                grantAccess.setId(grantAccessId);

                Account account = new AccountDao().layTheoMa(accountID).orElse(null);
                Role role = new RoleDao().layTheoMa((Object) roleID).orElse(null);
                if (account != null && role != null) {
                    grantAccess.setAccount(account);
                    grantAccess.setRole(role);
                    grantAccess.setIsGrant(true);
                    grantAccess.setNote("");

                    boolean success = grantAccessDao.them(grantAccess);
                    if (success) {
                        accessGranted = true;
                    }
                }
            }
        }

        if (accessGranted) {
            session.setAttribute("addStatus", "Thêm quyền truy cập thành công.");
        } else {
            session.setAttribute("addStatus", "Tất cả các quyền truy cập đã tồn tại hoặc không thành công.");
        }

        resp.sendRedirect("dashboard.jsp");
    }




    private void handleDeleteAccount(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        String accountID = req.getParameter("accountID");
        Account account = new Account(accountID);

        AccountDao accountDao = new AccountDao();
        boolean result = accountDao.xoa(account);

        if (result) {
            session.setAttribute("addStatus", "Xóa tài khoản thành công.");
        } else {
            session.setAttribute("addStatus", "Xóa tài khoản thất bại.");
        }

        resp.sendRedirect("dashboard.jsp");
    }

    private void handleDeleteGrantAccess(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        String accountID = req.getParameter("accountID");
        String roleID = req.getParameter("roleID");

        if (accountID == null || roleID == null || accountID.trim().isEmpty() || roleID.trim().isEmpty()) {
            session.setAttribute("addStatus", "Account ID and Role ID must not be empty.");
            resp.sendRedirect("dashboard.jsp");
            return;
        }

        GrantAccessDao grantAccessDao = new GrantAccessDao();

        boolean result = grantAccessDao.deleteGrantAccess(accountID, roleID);

        if (result) {
            session.setAttribute("addStatus", "Xóa quyền truy cập thành công.");
        } else {
            session.setAttribute("addStatus", "Xóa quyền truy cập thất bại.");
        }

        resp.sendRedirect("dashboard.jsp");
    }




    private void handleLogout(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        Account account = (Account) session.getAttribute("AccountData");
        if (account != null) {
            LogDao logDao = new LogDao();
            logDao.logLogout(account.getAccountId());

            session.invalidate();
            System.out.println("Logout successfully.");
        }

        resp.sendRedirect("index.jsp");
    }

}