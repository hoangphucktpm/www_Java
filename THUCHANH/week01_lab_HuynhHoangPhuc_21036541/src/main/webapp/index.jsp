<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
</head>
<body>
<h1>Login</h1>
<form action="controller" method="post">
    <input type="hidden" name="action" value="login">
    <label for="account_id">Account ID:</label>
    <input type="text" id="account_id" name="account_id" required><br><br>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br><br>
    <input type="submit" value="Login">
</form>
<p><a href="register.jsp">Register</a></p>
</body>
</html>
