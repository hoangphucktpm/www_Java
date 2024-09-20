<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="iuh.backend.services.ProductService" %>
<%@ page import="iuh.backend.models.Product" %>
<%@ page import="iuh.backend.models.Productimage" %>
<%@ page import="java.util.List" %>
<%@ page import="iuh.backend.models.Productprice" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        #container {
            width: 80%;
            margin: auto;
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
            border: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: #ffffff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .status-active { color: green; }
        .status-inactive { color: orange; }
        .status-terminated { color: red; }
        button {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
            width: 100px;
            text-align: center;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        button.delete {
            background-color: #dc3545;
        }

        button.update {
            background-color: #ffc107;
        }

        button:hover {
            background-color: #0056b3;
        }

        button.update:hover {
            background-color: #e0a800;
        }

        button.delete:hover {
            background-color: #c82333;
        }

        button.back, button.cart {
            background-color: #28a745;
        }

        button.back:hover, button.cart:hover {
            background-color: #218838;
        }

        a {
            text-decoration: none;
            color: #ffffff;
            font-weight: 500;
        }
        a:hover {
            text-decoration: underline;
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

<div id="container">
    <h3>Product List</h3>
    <div class="back-link">
        <a href="index.jsp">Trở về</a>
    </div>
    <button style="margin-bottom: 20px; padding: 10px 20px; background-color: #007bff; color: #ffffff; border: none; border-radius: 4px; cursor: pointer;">
        <a href="insertProduct.jsp">Thêm</a>
    </button>
    <table>
        <thead>
        <tr>
            <th>Id</th>
            <th>Image</th>
            <th>Name</th>
            <th>Description</th>
            <th>Unit</th>
            <th>Manufacturer</th>
            <th>Status</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            ProductService productService = new ProductService();
            List<Product> productList = productService.getAll();
            for (Product product : productList) {
                long id = product.getId();
                String edit_string = "controls?action=update_product&id=" + id;
                String delete_string = (product.getStatus().getValue() != 1) ?
                        "controls?action=active_product&id=" + id :
                        "controls?action=delete_product&id=" + id;
                Productimage randomImage = productService.getRandomProductImage(id);
        %>
        <tr>
            <td><%= product.getId() %></td>
            <td>
                <% if (randomImage != null) { %>
                <img src="<%= randomImage.getPath() %>" alt="<%= randomImage.getAlternative() %>" style="width: 100px; height: auto;">
                <% } %>
            </td>
            <td><%= product.getName() %></td>
            <td><%= product.getDescription() %></td>
            <td><%= product.getUnit() %></td>
            <td><%= product.getManufacturerName() %></td>
            <td class="<%= product.getStatus().getValue() == 1 ? "status-active" : product.getStatus().getValue() == 0 ? "status-inactive" : "status-terminated" %>">
                <%= product.getStatus().getValue() == 1 ? "Đang kinh doanh" : product.getStatus().getValue() == 0 ? "Tạm ngưng" : "Không kinh doanh nữa" %>
            </td>
            <td>
                <% for(Productprice price : productService.getProductByPrice(id)) { %>
                <%= price.getPrice() %><br>
                <% } %>
            </td>
            <td>
                <div class="actions">
                    <button class="update" onclick="window.location.href='updateProduct.jsp?id=<%= id %>';">Update</button>
                    <button class="<%= product.getStatus().getValue() == 1 ? "delete" : "update" %>" onclick="window.location.href='<%= delete_string %>';"><%= product.getStatus().getValue() == 1 ? "Delete" : "Activate" %></button>
                    <button class="cart">Add to Cart</button>
                </div>
            </td>


        </tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>