<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.entites.Account" %>
<%@ page import="iuh.week01_lab_huynhhoangphuc_21036541.servies.AccountServices" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Account</title>
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
</head>
<body>
<div class="container">
    <h1 class="mb-4 text-center">Edit Account</h1>
    <%
        String accountID = request.getParameter("accountID");
        AccountServices accountService = new AccountServices();
        Account account = accountService.layAccount(accountID, "");
    %>
    <form action="control-servlet" method="post">
        <input type="hidden" name="action" value="editAccount">
        <input type="hidden" name="accountID" value="<%= account.getAccountId() %>">
        <div class="form-group">
            <label for="fullName">Tên đầy đủ:</label>
            <input type="text" class="form-control" id="fullName" name="fullName" value="<%= account.getFullName() %>" required>
        </div>
        <div class="form-group">
            <label for="password">Mật khẩu:</label>
            <input type="password" class="form-control" id="password" name="password" value="<%= account.getPassword() %>" required>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= account.getEmail() %>" required>
        </div>
        <div class="form-group">
            <label for="phone">Điện thoại:</label>
            <input type="text" class="form-control" id="phone" name="phone" value="<%= account.getPhone() %>" required>
        </div>
        <div class="form-group">
            <label for="status">Status:</label>
            <input type="text" class="form-control" id="status" name="status" value="<%= account.getStatus() %>" required>
        </div>
        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</div>
</body>
</html>