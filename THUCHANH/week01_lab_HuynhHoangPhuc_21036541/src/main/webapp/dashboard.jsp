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
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 1200px;
            margin-top: 50px;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .btn-primary {
            /* Add your custom styles here */
        }
        .card {
            margin-bottom: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .table thead th {
            background-color: #007bff;
            color: #ffffff;
        }
        .btn-sm {
            margin-right: 5px;
        }
    </style>
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
    <%
        String addStatus = (String) session.getAttribute("addStatus");
        if (addStatus != null) {
    %>
    <div class="alert alert-info"><%= addStatus %></div>
    <%
            session.removeAttribute("addStatus");
        }
    %>
    <h1 class="mb-4">Quản lý tài khoản</h1>

    <a href='addAccount.jsp' class="btn btn-primary btn-sm mb-3">Thêm tài khoản</a>
    <form action="control-servlet" method="post" style="display:inline;">
        <input type="hidden" name="action" value="logout">
        <button type="submit" class="btn btn-danger btn-sm mb-3">Đăng xuất</button>
    </form>

    </form>
    <table class="table table-bordered table-hover">
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
                <a href='addGrantAccess.jsp?accountID=<%= account1.getAccountId() %>' class="btn btn-sm btn-primary">Thêm quyền</a> |
                <a href='editAccount.jsp?accountID=<%= account1.getAccountId() %>' class="btn btn-warning btn-sm">Sửa</a> |
                <a href='javascript:void(0);' onclick="confirmDeletion('<%= account1.getAccountId() %>')" class="btn btn-danger btn-sm">Xóa</a>

                <script>
                    function confirmDeletion(accountId) {
                        if (confirm('Bạn có chắc chắn muốn xóa tài khoản này không?')) {
                            window.location.href = 'control-servlet?action=deleteaccount&accountID=' + accountId;
                        }
                    }
                </script>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <h2 class="mt-5">Quản lý quyền truy cập</h2>
    <!-- Radio buttons for filtering -->
    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="roleFilter" id="filterAll" value="all" onclick="filterRoles()" checked>
        <label class="form-check-label" for="filterAll">All</label>
    </div>
    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="roleFilter" id="filterAdmin" value="admin" onclick="filterRoles()">
        <label class="form-check-label" for="filterAdmin">Admin</label>
    </div>
    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="roleFilter" id="filterUser" value="user" onclick="filterRoles()">
        <label class="form-check-label" for="filterUser">User</label>
    </div>

    <table class="table table-bordered table-hover mt-3">
        <thead class="thead-light">
        <tr>
            <th>Account ID</th>
            <th>Role ID</th>
            <th>Is Grant</th>
            <th>Ghi chú</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody id="grantAccessTable">
        <%
            for (GrantAccess grantAccess : grantAccessService.layDanhSachGrantAccess()) {
        %>
        <tr class="grant-access-row" data-role="<%= grantAccess.getRole().getRoleId() %>">
            <td><%= grantAccess.getAccount().getAccountId() %></td>
            <td><%= grantAccess.getRole().getRoleId() %></td>
            <td><%= grantAccess.getIsGrant() ? "1" : "0" %></td>
            <td><%= grantAccess.getNote() %></td>
            <td>
                <a href='addGrantAccess.jsp?accountID=<%= grantAccess.getAccount().getAccountId() %>' class="btn btn-sm btn-primary">Thêm</a> |
                <a href='editGrantAccess.jsp?accountID=<%= grantAccess.getAccount().getAccountId() %>&roleID=<%= grantAccess.getRole().getRoleId() %>' class="btn btn-warning btn-sm">Sửa</a> |
                <a href='javascript:void(0);' onclick="confirmDeletion2('<%= grantAccess.getAccount().getAccountId() %>','<%= grantAccess.getRole().getRoleId() %>')" class="btn btn-danger btn-sm">Xóa</a>
                <script>
                    function confirmDeletion2(accountId, roleId) {
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
    <h1 class="mb-4 text-center">Thông tin cá nhân</h1>
    <div class="card">
        <div class="card-body">
            <p><strong>Account ID:</strong> <%= account.getAccountId() %></p>
            <p><strong>Tên đầy đủ:</strong> <%= account.getFullName() %></p>
            <p><strong>Mật khẩu:</strong> <%= account.getPassword() %></p>
            <p><strong>Email:</strong> <%= account.getEmail() %></p>
            <p><strong>Điện thoại:</strong> <%= account.getPhone() %></p>
            <p><strong>Status:</strong> <%= account.getStatus() %></p>
            <h2>Quyền truy cập</h2>
            <table class="table table-bordered">
                <thead class="thead-light">
                <tr>
                    <th>Role Name</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Role role : roles) {
                %>
                <tr>
                    <td><%= role.getRoleName() %></td>
                </tr>
                <% } %>
                </tbody>
            </table>

        </div>
    </div>
    <form action="control-servlet" method="post" class="mt-3">
        <input type="hidden" name="action" value="logout">
        <button type="submit" class="btn btn-danger btn-block">Đăng xuất</button>
    </form>
</div>

<% } %>

<% } catch (Exception e) { %>
<div class="container mt-5">
    <h1>Error</h1>
    <p><%= e.getMessage() %></p>
</div>
<% } %>

<script>
    function filterRoles() {
        var selectedRole = document.querySelector('input[name="roleFilter"]:checked').value;
        var rows = document.querySelectorAll('.grant-access-row');
        rows.forEach(function(row) {
            if (selectedRole === 'all' || row.getAttribute('data-role') === selectedRole) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }
</script>
</body>
</html>