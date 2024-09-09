<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 09/09/2024
  Time: 11:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm quyền truy cập</title>
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
        hidden {
            display: none;
            color: red;
        }
    </style>
</head>
<body>

<h1>Thêm quyền truy cập</h1>
<form action="control-servlet" method="post">
    <input type="hidden" name="action" value="addGrantAccess">
    Tên tài khoản: <input type="text" name="accountID" required><br>
    Mã quyền: <input type="text" name="roleID" required><br>
    <input type="submit" value="Save">
</form>


</body>
</html>
