package iuh.frontend.controllers;


import iuh.frontend.model.CustomerModel;
import iuh.frontend.model.EmployeeModel;
import iuh.frontend.model.ProductModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/controls")
public class ServletController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Object obj = request.getParameter("action");
            if (obj != null) {
                String action = obj.toString();
                switch (action) {
                    case "insert_employee":
                        EmployeeModel employeeModel = new EmployeeModel();
                        employeeModel.insertEmployee(request, response);
                        break;
                    case "insert_products":
                        ProductModel productModel = new ProductModel();
                        productModel.insertProduct(request, response);
                        break;
                    case "insert_customer":
                        CustomerModel customerModel = new CustomerModel();
                        customerModel.insertCust(request, response);
                        break;
                    case "update_product":
                        ProductModel productUpdate = new ProductModel();
                        productUpdate.updateProduct(request, response);
                        break;
                    case "insert_price":
                        ProductModel productPrice = new ProductModel();
                        productPrice.insertPrice(request, response);
                        break;
                    default:
                        response.sendRedirect("index.jsp");
                        break;
                }
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Object obj = request.getParameter("action");
            if (obj != null) {
                String action = obj.toString();
                switch (action) {
                    case "delete_product":
                        ProductModel productModel = new ProductModel();
                        productModel.deleteProduct(request, response);
                        break;
                    case "delete_employee":
                        EmployeeModel employeeModel = new EmployeeModel();
                        employeeModel.deleteEmployee(request, response);
                        break;
                    case "active_employee":
                        EmployeeModel employeeModel2 = new EmployeeModel();
                        employeeModel2.activeEmployee(request, response);
                        break;
                    case "active_product":
                        ProductModel productModel2 = new ProductModel();
                        productModel2.activeProduct(request, response);
                        break;
                    default:
                        response.sendRedirect("index.jsp");
                        break;
                }
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }


}
