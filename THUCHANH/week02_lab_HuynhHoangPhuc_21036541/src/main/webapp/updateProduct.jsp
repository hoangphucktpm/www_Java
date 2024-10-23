<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="iuh.backend.models.Product" %>
<%@ page import="iuh.backend.services.ProductService" %>
<%@ page import="iuh.backend.enums.ProductStatus" %>
<%@ page import="java.util.Optional" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #007bff;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Update Product</h2>
    <%
        String idParam = request.getParameter("id");
        if (idParam == null) {
            out.println("<p>ID is missing!</p>");
            return;
        }

        long productId;
        try {
            productId = Long.parseLong(idParam);
        } catch (NumberFormatException e) {
            out.println("<p>Invalid ID format!</p>");
            return;
        }

        ProductService productService = new ProductService();
        Optional<Product> productOpt = productService.getProductById(productId);
        Product product = productOpt.orElse(null);

        if (product == null) {
    %>
    <p>Product not found!</p>
    <%
    } else {
    %>
    <form action="controls" method="post">
        <input type="hidden" name="action" value="update_product">
        <input type="hidden" name="id" value="<%= product.getId() %>">

        <label for="name">Name:</label>
        <input type="text" name="name" id="name" value="<%= product.getName() %>" required>

        <label for="description">Description:</label>
        <input type="text" name="description" id="description" value="<%= product.getDescription() %>" required>

        <label for="unit">Unit:</label>
        <input type="text" name="unit" id="unit" value="<%= product.getUnit() %>" required>

        <label for="manufacturer">Manufacturer:</label>
        <input type="text" name="manufacturer" id="manufacturer" value="<%= product.getManufacturerName() %>" required>

        <label for="status">Status:</label>
        <select name="status" id="status" required>
            <option value="ACTIVE" <%= product.getStatus() == ProductStatus.ACTIVE ? "selected" : "" %>>Active</option>
            <option value="INACTIVE" <%= product.getStatus() == ProductStatus.IN_ACTIVE ? "selected" : "" %>>Inactive</option>
            <option value="TERMINATED" <%= product.getStatus() == ProductStatus.TERMINATED ? "selected" : "" %>>Terminated</option>
        </select>

        <button type="submit">Update Product</button>
    </form>
    <%
        }
    %>
</div>

</body>
</html>
