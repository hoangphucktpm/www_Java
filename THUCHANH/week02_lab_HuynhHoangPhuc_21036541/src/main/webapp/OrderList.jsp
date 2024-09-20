<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="iuh.backend.services.OrderService" %>
<%@ page import="iuh.backend.models.Order" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management</title>
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
</head>
<body>
<div class="container">
    <h3>Order List</h3>
    <div class="back-link">
        <a href="index.jsp">Trở về</a>
    </div>
    <div class="insert-link">
        <a href="insertOrder.jsp">Thêm mới đơn hàng</a>
    </div>
    <%
        OrderService orderService = new OrderService();
        List<Order> orderList = orderService.getAll();
    %>
    <table>
        <thead>
        <tr>
            <th>Id</th>
            <th>Order Date</th>
            <th>Employee</th>
            <th>Customer</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for(Order order : orderList) {
            long id = order.getId();
            String detailString = "orderDetail.jsp?orderId=" + id; // Đường dẫn đến trang chi tiết hóa đơn
        %>
        <tr>
            <td align="center"><%= id %></td>
            <td><%= order.getOrderDate() %></td>
            <td><%= order.getEmp().getFullName() %></td>
            <td><%= order.getCust().getCustName() %></td>
            <td class="action-links">
                <a href="<%= detailString %>" class="view-details">Xem chi tiết hóa đơn</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
