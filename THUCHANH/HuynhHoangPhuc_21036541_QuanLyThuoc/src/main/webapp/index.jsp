<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        td {
            padding: 20px;
            text-align: center;
            font-size: 18px;
        }
        a {
            font-size: 16px;
            color: blue;
        }
    </style>
</head>
<body>
<br/>
<table border="1">
    <tr>
        <td>21036541 - Huỳnh Hoàng Phúc</td>
    </tr>
    <tr>
        <td>
            <a href="controller?action=listLoaiThuoc">Danh sách các loại thuốc</a> |
            <a href="controller?action=listThuoc">Danh sách thuốc</a> |
            <a href="controller?action=addThuoc">Thêm thuốc mới</a>
        </td>
    </tr>
</table>
</body>
</html>