package iuh.week01_lab_huynhhoangphuc_21036541.controllers;

import iuh.week01_lab_huynhhoangphuc_21036541.entites.Account;
import iuh.week01_lab_huynhhoangphuc_21036541.servies.AccountServices;
import iuh.week01_lab_huynhhoangphuc_21036541.servies.GrantAccessServices;
import iuh.week01_lab_huynhhoangphuc_21036541.servies.LogServices;
import iuh.week01_lab_huynhhoangphuc_21036541.servies.RoleServices;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet(name = "ControllerServlet", urlPatterns = "/controller")
public class ControllerServlet extends HttpServlet {

    private Connection connection;
    private AccountServices accountService;
    private RoleServices roleService;
    private GrantAccessServices grantAccessService;
    private LogServices logService;

    @Override
    public void init() throws ServletException {
        super.init();  // Gọi phương thức init của lớp cha nếu cần
        System.out.println("Initializing servlet..."); // Thêm dòng log
        try {
            // Cấu hình kết nối database
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");
            accountService = new AccountServices(connection);
            roleService = new RoleServices(connection);
            grantAccessService = new GrantAccessServices(connection);
            logService = new LogServices(connection);
            System.out.println("Database connection initialized");
        } catch (SQLException e) {
            throw new ServletException("Database connection error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "login":
                    handleLogin(request, response);
                    break;
                case "addAccount":
                    handleAddAccount(request, response);
                    break;
                case "updateAccount":
                    handleUpdateAccount(request, response);
                    break;
                case "deleteAccount":
                    handleDeleteAccount(request, response);
                    break;
                case "grantAccess":
                    handleGrantAccess(request, response);
                    break;
                case "logout":
                    handleLogout(request, response);
                    break;
                default:
                    response.sendRedirect("error.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String accountId = request.getParameter("account_id");
        String password = request.getParameter("password");

        Account account = accountService.getAccount(accountId);

        if (account != null && account.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("accountId", accountId);
            logService.logLogin(accountId);
            if (isAdmin(accountId)) {
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("userInfo.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid credentials");
        }
    }

    private void handleAddAccount(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Account account = new Account();
        account.setAccountId(request.getParameter("account_id"));
        account.setFullName(request.getParameter("full_name"));
        account.setPassword(request.getParameter("password"));
        account.setEmail(request.getParameter("email"));
        account.setPhone(request.getParameter("phone"));
        account.setStatus(Byte.parseByte(request.getParameter("status")));
        accountService.addAccount(account);
        response.sendRedirect("accountList.jsp");
    }

    private void handleUpdateAccount(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Account account = new Account();
        account.setAccountId(request.getParameter("account_id"));
        account.setFullName(request.getParameter("full_name"));
        account.setPassword(request.getParameter("password"));
        account.setEmail(request.getParameter("email"));
        account.setPhone(request.getParameter("phone"));
        account.setStatus(Byte.parseByte(request.getParameter("status")));
        accountService.updateAccount(account);
        response.sendRedirect("accountList.jsp");
    }

    private void handleDeleteAccount(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String accountId = request.getParameter("account_id");
        accountService.deleteAccount(accountId);
        response.sendRedirect("accountList.jsp");
    }

    private void handleGrantAccess(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String accountId = request.getParameter("account_id");
        String roleId = request.getParameter("role_id");
        boolean isGrant = "1".equals(request.getParameter("is_grant"));
        String note = request.getParameter("note");
        grantAccessService.grantAccess(accountId, roleId, isGrant, note);
        response.sendRedirect("accessList.jsp");
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        HttpSession session = request.getSession();
        String accountId = (String) session.getAttribute("accountId");
        if (accountId != null) {
            logService.logLogout(accountId);
        }
        session.invalidate();
        response.sendRedirect("login.jsp");
    }

    private boolean isAdmin(String accountId) throws SQLException {
        // Kiểm tra nếu tài khoản có quyền admin (thay đổi tùy vào cách bạn xác định quyền admin)
        // Ví dụ: kiểm tra quyền admin trong cơ sở dữ liệu hoặc trong một cấu hình
        // Placeholder logic: trả về true cho tất cả các tài khoản
        return accountId.startsWith("admin"); // Thay thế logic này với cách xác định admin thực tế
    }

    @Override
    public void destroy() {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
