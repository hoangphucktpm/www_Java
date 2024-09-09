<%@ page import="java.util.List" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.entites.Account" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.servies.AccountServices" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.servies.RoleServices" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.servies.GrantAccessServices" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.entites.Role" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.entites.GrantAccess" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<%
    try {
        Account account = (Account) session.getAttribute("AccountData");

        if (account == null) {
            throw new Exception("Tài khoản không tồn tại.");
        }

        String accountID = account.getAccountId();
        String password = account.getPassword();

        if (accountID == null || password == null || accountID.trim().isEmpty() || password.trim().isEmpty()) {
            throw new Exception("Tài khoản không hợp lệ.");
        }

        AccountServices accountService = new AccountServices();
        account = accountService.layAccount(accountID, password);

        if (account == null) {
            throw new Exception("Tài khoản không tồn tại.");
        }

        RoleServices roleService = new RoleServices();
        boolean isAdmin = false;
        List<Role> roles = roleService.layDanhSachRoleByAccount(accountID);

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
<div class="container mt-5">
    <h1 class="mb-4">Quản lý tài khoản</h1>
    <a href='addAccount.jsp' class="btn btn-primary mb-3">Thêm tài khoản</a>
    <form action="control-servlet" method="post" style="display:inline;">
        <input type="hidden" name="action" value="logout">
        <input type="submit" value="Đăng xuất" class="btn btn-danger mb-3">
    </form>
    <table class="table table-bordered">
        <thead class="thead-light">
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
                <a href='editAccount.jsp?accountID=<%= account1.getAccountId() %>' class="btn btn-warning btn-sm">Sửa</a> |
                <a href='javascript:void(0);' onclick="confirmDeletion('<%= account1.getAccountId() %>')" class="btn btn-danger btn-sm">Xóa</a>

                <script>
                    function confirmDeletion(accountId) {
                        if (confirm('Bạn có chắc chắn muốn xóa tài khoản này không?')) {
                            window.location.href = 'control-servlet?action=deleteAccount&accountID=' + accountId;
                        }
                    }
                </script>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <h2 class="mt-5">Cấp quyền</h2>
    <table class="table table-bordered">
        <thead class="thead-light">
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
                <a href='addGrantAccess.jsp?accountID=<%= grantAccess.getAccount().getAccountId() %>' class="btn btn-primary btn-sm">Thêm</a> |
                <a href='editGrantAccess.jsp?accountID=<%= grantAccess.getAccount().getAccountId() %>&roleID=<%= grantAccess.getRole().getRoleId() %>' class="btn btn-warning btn-sm">Sửa</a> |
                <a href='javascript:void(0);' onclick="confirmDeletion('<%= grantAccess.getAccount().getAccountId() %>','<%= grantAccess.getRole().getRoleId() %>')" class="btn btn-danger btn-sm">Xóa</a>
                <script>
                    function confirmDeletion(accountId, roleId) {
                        if (confirm('Bạn có chắc chắn muốn xóa quyền này không?')) {
                            window.location.href = 'control-servlet?action=deleteGrantAccess&accountID=' + accountId + '&roleID=' + roleId;
                        }
                    }
                </script>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<% } else { %>
<!-- User Info -->
<div class="container mt-5">
    <h1>Thông tin cá nhân</h1>
    <p>
        Account ID: <%= account.getAccountId() %> <br>
        Tên đầy đủ: <%= account.getFullName() %> <br>
        Mật khẩu: <%= account.getPassword() %> <br>
        Email: <%= account.getEmail() %> <br>
        Điện thoại: <%= account.getPhone() %> <br>
        Status: <%= account.getStatus() %> <br>
    </p>
    <form action="control-servlet" method="post">
        <input type="hidden" name="action" value="logout">
        <input type="submit" value="Đăng xuất" class="btn btn-danger">
    </form>
</div>

<% } %>

<% } catch (Exception e) { %>
<div class="container mt-5">
    <h1>Error</h1>
    <p><%= e.getMessage() %></p>
</div>
<% } %>
</body>
</html>