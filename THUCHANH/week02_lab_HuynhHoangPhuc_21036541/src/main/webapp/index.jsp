<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LAB WEEK 2</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #e9ecef;
            color: #495057;
        }
        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #007bff;
            font-size: 2.5rem;
            margin-bottom: 20px;
        }
        .nav-links {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }
        .nav-links a {
            text-decoration: none;
            color: #ffffff;
            background-color: #007bff;
            padding: 12px 25px;
            border-radius: 5px;
            font-size: 1.1rem;
            transition: background-color 0.3s, transform 0.3s;
        }
        .nav-links a:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }
        .nav-links a:active {
            transform: translateY(1px);
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Welcome to My Web Application</h1>
    <div class="nav-links">
        <a href="product.jsp">Product</a>
        <a href="Employees.jsp">Employees</a>
        <a href="Customer.jsp">Customer</a>
    </div>
</div>
</body>
</html>
