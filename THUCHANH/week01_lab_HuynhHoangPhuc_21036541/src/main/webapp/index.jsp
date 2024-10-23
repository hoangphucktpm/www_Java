<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
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
            max-width: 400px;
            margin-top: 100px;
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
        .text-danger {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="mb-4 text-center">Đăng nhập tài khoản</h1>
    <form action="control-servlet" method="post">
        <div class="form-group">
            <label for="accountID">Tên tài khoản:</label>
            <input type="text" class="form-control" id="accountID" name="accountID" placeholder="userName" required>
        </div>
        <div class="form-group">
            <label for="password">Mật khẩu:</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="password" required>
        </div>
        <button type="submit" class="btn btn-primary" name="action" value="login">Login</button>
        <br>
        <%
            String loginStatus = (String) session.getAttribute("loginStatus");
            if (loginStatus != null) {
        %>
        <p class="mt-3 text-danger"> <%= loginStatus %> </p>
        <%
                session.removeAttribute("loginStatus");
            }
        %>
        <%
            session.setAttribute("action", "login");
        %>
    </form>
</div>
</body>
</html>