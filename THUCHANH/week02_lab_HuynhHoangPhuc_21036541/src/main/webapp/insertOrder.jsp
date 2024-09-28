<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="iuh.backend.services.EmployeeService, iuh.backend.services.CustomerService, iuh.backend.services.ProductService, iuh.backend.models.Employee, iuh.backend.models.Customer, iuh.backend.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="iuh.backend.models.Productprice" %>

<%
    // Lấy danh sách nhân viên, khách hàng và sản phẩm từ các service
    EmployeeService employeeService = new EmployeeService();
    List<Employee> employees = employeeService.getAll();

    CustomerService customerService = new CustomerService();
    List<Customer> customers = customerService.getAll();

    ProductService productService = new ProductService();
    List<Product> products = productService.getAll();



%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm mới đơn hàng</title>
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
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 5px;
            font-weight: bold;
        }
        input, select {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #dee2e6;
            border-radius: 5px;
        }
        table {
            width: 100%;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #dee2e6;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        button {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #28a745;
            color: #ffffff;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
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
        .product-table {
            margin-top: 20px;
        }
        .product-table select {
            width: 100%;
        }
    </style>
</head>
<body>
<div class="container">
    <h3>Thêm mới đơn hàng</h3>
    <div class="back-link">
        <a href="OrderList.jsp">Trở về</a>
    </div>
    <form action="insertOrderAction.jsp" method="post">
        <!-- Ngày đặt hàng -->
        <label for="orderDate">Ngày đặt hàng:</label>
        <input type="date" id="orderDate" name="orderDate" required>

        <!-- Nhân viên -->
        <label for="employee">Nhân viên:</label>
        <select id="employee" name="employee" required>
            <% for (Employee employee : employees) { %>
            <option value="<%= employee.getId() %>"><%= employee.getFullName() %></option>
            <% } %>
        </select>

        <!-- Khách hàng -->
        <label for="customer">Khách hàng:</label>
        <select id="customer" name="customer" required>
            <% for (Customer customer : customers) { %>
            <option value="<%= customer.getId() %>"><%= customer.getCustName() %></option>
            <% } %>
        </select>

        <!-- Bảng sản phẩm -->
        <div class="product-table">
            <table>
                <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Số lượng</th>
                </tr>
                </thead>
                <tbody id="productRows">
                <tr>
                    <td>
                        <select name="products[]" required>
                            <% for (Product product : products) { %>
                            <option value="<%= product.getId() %>">
                                <%= product.getName() %> -
                                <%
                                    // Gọi phương thức để lấy danh sách giá dựa trên productId
                                    for(Productprice price : productService.getProductByPrice(product.getId())) {
                                %>
                                Giá: <%= price.getPrice() %> VND
                                <% } %>
                            </option>
                            <% } %>
                        </select>

                    </td>
                    <td><input type="number" name="quantities[]" min="1" required></td>
                </tr>
                </tbody>
            </table>
        </div>

        <button type="button" onclick="addProductRow()">Thêm sản phẩm</button>
        <br>

        <button type="submit">Thêm đơn hàng</button>
    </form>
</div>

<script>
    function addProductRow() {
        const tableBody = document.getElementById('productRows');
        const newRow = document.createElement('tr');

        newRow.innerHTML = `
            <td>
                <select name="products[]" required>
                    <% for (Product product : products) { %>
                        <option value="<%= product.getId() %>"><%= product.getName() %> - Giá: <%= product.getStatus() %></option>
                    <% } %>
                </select>
            </td>
            <td><input type="number" name="quantities[]" min="1" required></td>
        `;

        tableBody.appendChild(newRow);
    }
</script>
</body>
</html>
