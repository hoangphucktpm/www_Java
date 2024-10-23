<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="iuh.backend.services.OrderService" %>
<%@ page import="iuh.backend.models.Orderdetail" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.DriverManager" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Detail</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #343a40;
        }
        .container {
            max-width: 800px;
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
    <h3>Chi tiết hóa đơn</h3>
    <div class="back-link">
        <a href="OrderList.jsp">Trở về danh sách hóa đơn</a>
    </div>
    <%
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam != null) {
            long orderId = Long.parseLong(orderIdParam);
            String query = "SELECT " +
                    "o.order_id, " +
                    "o.order_date, " +
                    "e.full_name AS employee_name, " +
                    "c.cust_name AS customer_name, " +
                    "od.product_id, " +
                    "p.name AS product_name, " +
                    "od.quantity, " +
                    "od.price, " +
                    "od.note " +
                    "FROM orders o " +
                    "JOIN orderdetail od ON o.order_id = od.order_id " +
                    "JOIN product p ON od.product_id = p.product_id " +
                    "JOIN employee e ON o.emp_id = e.emp_id " +
                    "JOIN customer c ON o.cust_id = c.cust_id " +
                    "WHERE o.order_id = ?";

            String jdbcUrl = "jdbc:mariadb://localhost:3306/mydb_week2";
            String username = "root";
            String password = "root";

            try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
                 PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setLong(1, orderId);
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    out.println("<table>");
                    out.println("<tr><th>Order ID</th><td>" + resultSet.getLong("order_id") + "</td></tr>");
                    out.println("<tr><th>Order Date</th><td>" + resultSet.getString("order_date") + "</td></tr>");
                    out.println("<tr><th>Employee</th><td>" + resultSet.getString("employee_name") + "</td></tr>");
                    out.println("<tr><th>Customer</th><td>" + resultSet.getString("customer_name") + "</td></tr>");
                    out.println("</table>");

                    out.println("<h4>Order Items:</h4>");
                    out.println("<table>");
                    out.println("<thead><tr><th>Product ID</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Note</th></tr></thead>");
                    out.println("<tbody>");

                    do {
                        out.println("<tr>");
                        out.println("<td>" + resultSet.getLong("product_id") + "</td>");
                        out.println("<td>" + resultSet.getString("product_name") + "</td>");
                        out.println("<td>" + resultSet.getInt("quantity") + "</td>");
                        out.println("<td>" + resultSet.getDouble("price") + "</td>");
                        out.println("<td>" + resultSet.getString("note") + "</td>");
                        out.println("</tr>");
                    } while (resultSet.next());

                    out.println("</tbody></table>");
                } else {
                    out.println("<p>Không tìm thấy hóa đơn với ID: " + orderId + "</p>");
                }
            } catch (SQLException e) {
                out.println("<p>Có lỗi xảy ra khi truy xuất dữ liệu: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p>Không có ID hóa đơn được cung cấp.</p>");
        }
    %>
</div>
</body>
</html>
