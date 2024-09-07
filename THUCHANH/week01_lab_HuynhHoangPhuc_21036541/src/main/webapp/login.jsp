<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h1>Login</h1>
<form action="controller" method="post">
    <input type="hidden" name="action" value="login" />
    <label for="account_id">Account ID:</label>
    <input type="text" id="account_id" name="account_id" required /><br/>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required /><br/>
    <input type="submit" value="Login" />
</form>
<c:if test="${param.error != null}">
    <p style="color: red;">Invalid credentials</p>
</c:if>
</body>
</html>
