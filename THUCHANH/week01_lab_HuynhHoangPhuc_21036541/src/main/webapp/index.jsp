<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h1>Đăng nhập tài khoản</h1>
<form action="control-servlet" method="post">
    Tên tài khoản: <input type="text" name="accountID" placeholder="userName" required>
    Mật khẩu: <input type="password" name="password" placeholder="password" required>
    <input type="submit" name="action" value="login"><br>

    <%
        String loginStatus = (String) session.getAttribute("loginStatus");
        if (loginStatus != null) {
    %>
    <p style="font-size: 15px; color: red"> <%= loginStatus %> </p>
    <%
            session.removeAttribute("loginStatus");
        }
    %>

    <%
        session.setAttribute("action", "login");
    %>
</form>

</body>
</html>
