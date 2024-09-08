<%@ page import="java.util.List" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.entites.Account" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.servies.AccountServices" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.servies.RoleServices" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.servies.GrantAccessServices" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.entites.Role" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.entites.GrantAccess" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard</title>
    <style>
        div {
            width: 100%;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            text-align: center;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<%
    try {
        Account account = (Account) session.getAttribute("AccountData");

        if (account == null) {
            throw new Exception("Account data is not available.");
        }

        String accountID = account.getAccountId();
        String password = account.getPassword();

        if (accountID == null || password == null || accountID.trim().isEmpty() || password.trim().isEmpty()) {
            throw new Exception("Account ID and password must not be empty.");
        }

        AccountServices accountService = new AccountServices();
        account = accountService.layAccount(accountID, password);

        if (account == null) {
            throw new Exception("Invalid Account ID or Password.");
        }

        RoleServices roleService = new RoleServices();
        boolean isAdmin = false;
        List<Role> roles = roleService.layDanhSachRole();

        for (Role role : roles) {
            if (role.getRoleId().equals("admin")) {
                isAdmin = true;
                break;
            }
        }

        // Khởi tạo GrantAccessServices
        GrantAccessServices grantAccessService = new GrantAccessServices();

%>

<% if (isAdmin) { %>
<!-- Admin Dashboard -->
<div>
    <h1>Quản lý tài khoản</h1>
    <table>
        <thead>
        <tr>
            <th>Account ID</th>
            <th>Họ và Tên</th>
            <th>Mật khẩu</th>
            <th>Email</th>
            <th>Điện thoại</th>
            <th>Status</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Account account1 : accountService.layDanhSachAccount()) {
        %>
        <tr>
            <td><%= account1.getAccountId() %></td>
            <td><%= account1.getFullName() %></td>
            <td><%= account1.getPassword() %></td>
            <td><%= account1.getEmail() %></td>
            <td><%= account1.getPhone() %></td>
            <td><%= account1.getStatus() %></td>
            <td>
                <a href='editAccount.jsp?accountID=<%= account1.getAccountId() %>'>Sửa</a> |
                <a href='deleteAccount.jsp?accountID=<%= account1.getAccountId() %>'>Xóa</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <h2>Cấp quyền</h2>
    <table>
        <thead>
        <tr>
            <th>Account ID</th>
            <th>Role ID</th>
            <th>Is Grant</th>
            <th>Ghi chú</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (GrantAccess grantAccess : grantAccessService.layDanhSachGrantAccess()) {
        %>
        <tr>
            <td><%= grantAccess.getAccount().getAccountId() %></td>
            <td><%= grantAccess.getRole().getRoleId() %></td>
            <td><%= grantAccess.getIsGrant() ? "1" : "0" %></td>
            <td><%= grantAccess.getNote() %></td>
            <td>
                <a href='grantAccess.jsp?accountID=<%= grantAccess.getAccount().getAccountId() %>&roleID=<%= grantAccess.getRole().getRoleId() %>'>Cấp quyền</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<% } else { %>
<!-- User Info -->
<div>
    <h1>Thông tin cá nhân</h1>
    <p>
        Account ID: <%= account.getAccountId() %> <br>
        Tên đầy đủ: <%= account.getFullName() %> <br>
        Mật khẩu: <%= account.getPassword() %> <br>
        Email: <%= account.getEmail() %> <br>
        Điện thoại: <%= account.getPhone() %> <br>
        Status: <%= account.getStatus() %> <br>
    </p>
</div>

<div>
    <h1>Quản lý vai trò của bạn</h1>
    <table>
        <thead>
        <tr>
            <th>Role ID</th>
            <th>Role Name</th>
            <th>Mô tả</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Khởi tạo lại GrantAccessServices nếu cần
            List<GrantAccess> userRoles = grantAccessService.layDanhSachGrantAccess();
            for (GrantAccess grantAccess : userRoles) {
                Role role = grantAccess.getRole();
        %>
        <tr>
            <td><%= role.getRoleId() %></td>
            <td><%= role.getRoleName() %></td>
            <td><%= role.getDescription() %></td>
            <td><%= role.getStatus() %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
<% } %>

<% } catch (Exception e) { %>
<div>
    <h1>Error</h1>
    <p><%= e.getMessage() %></p>
</div>
<% } %>
</body>
</html>
