<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="iuh.backend.services.CustomerService" %>
<%@ page import="iuh.backend.models.Customer" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #343a40;
        }
        .container {
            max-width: 1000px;
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
            margin-bottom: 20px;
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
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
        }
        a:hover {
            text-decoration: underline;
        }
        .action-links {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .action-links a {
            background-color: #28a745;
            color: #ffffff;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .action-links a.update {
            background-color: #ffc107;
        }
        .action-links a.delete {
            background-color: #dc3545;
        }
        .action-links a:hover {
            background-color: #0056b3;
        }
        .action-links a.update:hover {
            background-color: #e0a800;
        }
        .action-links a.delete:hover {
            background-color: #c82333;
        }
        .insert-link {
            display: block;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h3>Customer List</h3>
    <%
        CustomerService customerService = new CustomerService();
        List<Customer> customerList = customerService.getAll();
    %>
    <table>
        <thead>
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Address</th>
            <th colspan="2">
                <a href="insertCustomer.jsp" class="action-links">Insert</a>
            </th>
        </tr>
        </thead>
        <tbody>
        <% for(Customer customer : customerList) {
            long id = customer.getId();
            String deleteString = "controls?action=delete_customer&id=" + id;
            String editString = "controls?action=edit_customer&id=" + id;
        %>
        <tr>
            <td align="center"><%= id %></td>
            <td><%= customer.getCustName() %></td>
            <td><%= customer.getEmail() %></td>
            <td><%= customer.getPhone() %></td>
            <td><%= customer.getAddress() %></td>
            <td class="action-links">
                <a href="<%= editString %>" class="update">Update</a>
            </td>
            <td class="action-links">
                <a href="<%= deleteString %>" class="delete">Delete</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
