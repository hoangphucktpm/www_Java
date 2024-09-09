<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 09/09/2024
  Time: 11:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.entites.Account" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.servies.AccountServices" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.entites.Role" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.servies.RoleServices" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm quyền truy cập</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            margin-top: 50px;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .btn-primary {
            width: 100%;
        }
    </style>
    <script>
        function updateRoles() {
            const selectedRoles = [];
            document.querySelectorAll('.form-check-input:checked').forEach(checkbox => {
                selectedRoles.push(checkbox.dataset.roleName);
            });
            document.getElementById('currentRoles').innerHTML = selectedRoles.join(', ');
        }
    </script>
</head>
<body>
<div class="container">
    <h1 class="mb-4 text-center">Thêm quyền truy cập</h1>
    <form action="control-servlet" method="post">
        <input type="hidden" name="action" value="addGrantAccess">
        <input type="hidden" name="accountID" value="<%= request.getParameter("accountID") %>">
        <div class="form-group">
            <label>Tên tài khoản:</label>
            <p><%= request.getParameter("accountID") %> - <%= new AccountServices().layAccount(request.getParameter("accountID"), "").getFullName() %></p>
            <label>Role hiện có:</label>
            <p id="currentRoles" class="form-control">
                <%
                    String accountId = request.getParameter("accountID");
                    List<Role> userRoles = new RoleServices().layDanhSachRoleByAccount(accountId);
                    for (int i = 0; i < userRoles.size(); i++) {
                        Role role = userRoles.get(i);
                        if (i > 0) {
                            out.print(", ");
                        }
                        out.print(role.getRoleName());
                    }
                %>
            </p>
        </div>
        <div class="form-group">
            <label>Chọn quyền:</label>
            <div>
                <%
                    String selectedAccountId = request.getParameter("accountID");
                    if (selectedAccountId != null) {
                        List<Role> roles = new RoleServices().layDanhSachRole();
                        for (Role role : roles) {
                %>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="role_<%= role.getRoleId() %>" name="roleIDs[]" value="<%= role.getRoleId() %>" data-role-name="<%= role.getRoleName() %>"
                           <%
            boolean isChecked = false;
            for (Role userRole : userRoles) {
                if (userRole.getRoleId().equals(role.getRoleId())) {
                    isChecked = true;
                    break;
                }
            }
            if (isChecked) {
        %>checked<%
            }
        %> onchange="updateRoles()">
                    <label class="form-check-label" for="role_<%= role.getRoleId() %>"><%= role.getRoleName() %></label>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Save</button>
        <button type="button" class="btn btn-secondary" onclick="window.location.href='dashboard.jsp'">Cancel</button>

    </form>
</div>
</body>
</html>