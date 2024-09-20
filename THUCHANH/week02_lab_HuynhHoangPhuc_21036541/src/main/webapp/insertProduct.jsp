<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="iuh.backend.services.ProductService" %>
<%@ page import="iuh.backend.models.Productprice" %>
<%@ page import="java.util.List" %>

<%
    ProductService productService = new ProductService();
    List<Productprice> productprices = productService.getAllPrice();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Product</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        #container {
            width: 80%;
            max-width: 700px;
            margin: 2% auto;
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
        td {
            padding: 10px;
            text-align: left;
        }
        input[type="text"], select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"], input[type="reset"], button {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover, input[type="reset"]:hover, button:hover {
            background-color: #0056b3;
        }
        input[type="reset"] {
            background-color: #6c757d;
        }
        input[type="reset"]:hover {
            background-color: #5a6268;
        }
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .btn-container {
            display: flex;
            justify-content: space-between;
        }
        .btn-container td {
            border: none;
        }
        button {
            background-color: #28a745;
        }
        button:hover {
            background-color: #218838;
        }
        .additional-fields {
            display: none;
        }
    </style>
    <script>
        function showAdditionalFields() {
            var additionalFields = document.getElementById("additionalFields");
            additionalFields.style.display = "table-row-group";
            document.getElementById("saveButton").style.display = "inline-block";
            document.getElementById("cancelButton").style.display = "inline-block";
        }

        function hideAdditionalFields() {
            var additionalFields = document.getElementById("additionalFields");
            additionalFields.style.display = "none";
            document.getElementById("saveButton").style.display = "none";
            document.getElementById("cancelButton").style.display = "none";
        }

        function saveNewPrice() {
            var newPrice = document.querySelector('input[name="new_price"]').value;
            var note = document.querySelector('input[name="note"]').value;
            var productId = document.querySelector('input[name="product_id"]').value;

            var formData = new FormData();
            formData.append('new_price', newPrice);
            formData.append('note', note);
            formData.append('product_id', productId);

            fetch('controls?action=insert_price', {
                method: 'POST',
                body: formData
            })
                .then(response => {
                    if (response.ok) {
                        alert("Giá mới đã được lưu!");
                        hideAdditionalFields();
                    } else {
                        response.text().then(text => alert("Có lỗi xảy ra: " + text));
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("Có lỗi xảy ra. Vui lòng thử lại.");
                });
        }

        function validateForm() {
            return true;
        }
    </script>
</head>
<body>
<div id="container">
    <h3>Insert New Product</h3>
    <form action="controls?action=insert_products" method="post" onsubmit="return validateForm();">
        <table>
            <tr>
                <td>Product ID:</td>
                <td><input type="text" name="product_id" value="<%= productService.getNextProductId() %>" readonly></td>
            </tr>
            <tr>
                <td>Product Name:</td>
                <td><input type="text" name="name" required></td>
            </tr>
            <tr>
                <td>Description:</td>
                <td><input type="text" name="description" required></td>
            </tr>
            <tr>
                <td>Unit:</td>
                <td><input type="text" name="unit" required></td>
            </tr>
            <tr>
                <td>Manufacturer:</td>
                <td><input type="text" name="manufacturer" required></td>
            </tr>
            <tr>
                <td>Status:</td>
                <td>
                    <select name="status" required>
                        <option value="ACTIVE">ACTIVE</option>
                        <option value="INACTIVE">INACTIVE</option>
                        <option value="TERMINATED">TERMINATED</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Price:</td>
                <td>
                    <select name="price" required>
                        <% for (Productprice productprice : productprices) { %>
                        <option value="<%= productprice.getId() %>"><%= productprice.getPrice() %></option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr class="btn-container">
                <td></td>
                <td class="form-actions">
                    <button type="button" onclick="showAdditionalFields()">New</button>
                </td>
            </tr>
            <tbody id="additionalFields" class="additional-fields">
            <tr>
                <td>New Price:</td>
                <td><input type="text" name="new_price"></td> <!-- Không cần required -->
            </tr>
            <tr>
                <td>Note:</td>
                <td><input type="text" name="note"></td> <!-- Không cần required -->
            </tr>
            </tbody>
            <tr>
                <td colspan="2" class="form-actions">
                    <input type="submit" value="Insert">
                    <input type="reset" value="Reset">
                    <button type="button" id="saveButton" style="display:none;" onclick="saveNewPrice()">Save</button>
                    <button type="button" id="cancelButton" style="display:none;" onclick="hideAdditionalFields()">Cancel</button>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>