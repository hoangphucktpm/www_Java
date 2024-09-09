<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Accounts by Role</title>
</head>
<body>
<h2>Accounts for Role: ${param.roleId}</h2>

<!-- Admin Accounts Table -->
<h3>Admin Accounts</h3>
<c:if test="${not empty accountsByRole}">
    <table border="1">
        <tr>
            <th>Account ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Status</th>
        </tr>
        <c:forEach var="account" items="${accountsByRole}">
            <c:if test="${account.role.roleId == 'admin'}">
                <tr>
                    <td>${account.accountId}</td>
                    <td>${account.fullName}</td>
                    <td>${account.email}</td>
                    <td>${account.phone}</td>
                    <td>${account.status}</td>
                </tr>
            </c:if>
        </c:forEach>
    </table>
</c:if>
<c:if test="${empty accountsByRole}">
    <p>No admin accounts found for this role.</p>
</c:if>

<!-- User Accounts Table -->
<h3>User Accounts</h3>
<c:if test="${not empty accountsByRole}">
    <table border="1">
        <tr>
            <th>Account ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Status</th>
        </tr>
        <c:forEach var="account" items="${accountsByRole}">
            <c:if test="${account.role.roleId == 'user'}">
                <tr>
                    <td>${account.accountId}</td>
                    <td>${account.fullName}</td>
                    <td>${account.email}</td>
                    <td>${account.phone}</td>
                    <td>${account.status}</td>
                </tr>
            </c:if>
        </c:forEach>
    </table>
</c:if>
<c:if test="${empty accountsByRole}">
    <p>No user accounts found for this role.</p>
</c:if>

</body>
</html>