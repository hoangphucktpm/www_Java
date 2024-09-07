<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Account List</title>
</head>
<body>
<h1>Account List</h1>
<table>
    <tr>
        <th>Account ID</th>
        <th>Full Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
    <!-- Iterate over accounts and display them -->
    <c:forEach var="account" items="${requestScope.accounts}">
        <tr>
            <td>${account.accountId}</td>
            <td>${account.fullName}</td>
            <td>${account.email}</td>
            <td>${account.phone}</td>
            <td>${account.status}</td>
            <td>
                <a href="editAccount.jsp?account_id=${account.accountId}">Edit</a>
                <a href="controller?action=deleteAccount&account_id=${account.accountId}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="addAccount.jsp">Add Account</a>
</body>
</html>
