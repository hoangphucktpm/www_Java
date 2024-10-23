<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Customer</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #495057;
        }

        input[type="text"], input[type="email"], input[type="tel"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"], input[type="reset"] {
            width: 48%;
            padding: 12px;
            background-color: #007bff;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        input[type="reset"] {
            background-color: #dc3545;
            margin-left: 4%;
        }

        input[type="reset"]:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Insert Customer</h2>
    <form action="controls?action=insert_customer" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" placeholder="Enter full name" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" placeholder="Enter email" required>

        <label for="phone">Phone:</label>
        <input type="tel" id="phone" name="phone" placeholder="Enter phone number" required>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" placeholder="Enter address" required>

        <div style="display: flex; justify-content: space-between;">
            <input type="submit" value="Insert">
            <input type="reset" value="Clear">
        </div>
    </form>
</div>
</body>
</html>
