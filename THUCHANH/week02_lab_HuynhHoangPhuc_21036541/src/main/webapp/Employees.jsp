<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="iuh.backend.services.EmployeeService" %>
<%@ page import="iuh.backend.models.Employee" %>
<%@ page import="iuh.backend.enums.EmloyeeStatus" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employees</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #343a40;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h3 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #dee2e6;
        }
        th {
            background-color: #007bff;
            color: #ffffff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        a {
            text-decoration: none;
            color: #007bff;
            font-weight: 500;
        }
        a:hover {
            text-decoration: underline;
        }
        button {
            background-color: #28a745;
            color: #ffffff;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        button.update {
            background-color: #ffc107;
        }
        button.delete {
            background-color: #dc3545;
        }
        button:hover {
            background-color: #218838;
        }
        button.update:hover {
            background-color: #e0a800;
        }
        button.delete:hover {
            background-color: #c82333;
        }
        .insert-link {
            display: block;
            text-align: right;
            margin-bottom: 20px;
        }
        .insert-link a {
            background-color: #28a745;
            color: #ffffff;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: bold;
            text-decoration: none;
        }
        .insert-link a:hover {
            background-color: #218838;
        }
        .back-link {
            text-align: left;
            margin-bottom: 20px;
        }
        .back-link a {
            font-weight: bold;
            color: #007bff;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            background-color: #f8f9fa;
            border: 1px solid #007bff;
            transition: background-color 0.3s, color 0.3s;
        }
        .back-link a:hover {
            background-color: #007bff;
            color: #ffffff;
        }
    </style>
    <script>
        function confirmAction(url, message) {
            if (confirm(message)) {
                window.location.href = url;
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h3>Employees List</h3>
    <div class="back-link">
        <a href="index.jsp">Trở về</a>
    </div>
    <div class="insert-link">
        <a href="insertEmployee.jsp" style="font-weight: bold;">Insert New Employee</a>
    </div>
    <%
        EmployeeService employeeService = new EmployeeService();
        List<Employee> employeeList = employeeService.getAll();
    %>
    <table>
        <thead>
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Date of Birth</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Status</th>
            <th colspan="2">Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for(Employee employee : employeeList) {
            long id = employee.getId();
            String actionUrl = (employee.getStatus().getValue() == 1) ?
                    "controls?action=delete_employee&id=" + id :
                    "controls?action=active_employee&id=" + id;
            String actionText = (employee.getStatus().getValue() == 1) ? "Delete" : "Activate";
            String buttonClass = (employee.getStatus().getValue() == 1) ? "delete" : "update";
        %>
        <tr>
            <td align="center"><%= id %></td>
            <td><%= employee.getFullName() %></td>
            <td><%= employee.getDob() %></td>
            <td><%= employee.getEmail() %></td>
            <td><%= employee.getPhone() %></td>
            <td><%= employee.getAddress() %></td>
            <td><%= employee.getStatus() %></td>
            <td><button class="update"><a href="controls?action=edit_employee&id=<%= id %>">Update</a></button></td>
            <td><button class="<%= buttonClass %>" onclick="confirmAction('<%= actionUrl %>', 'Are you sure you want to <%= actionText %> this employee?')"><%= actionText %></button></td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
