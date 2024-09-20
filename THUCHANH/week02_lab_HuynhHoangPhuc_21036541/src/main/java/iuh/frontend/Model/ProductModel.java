package iuh.frontend.model;

import iuh.backend.enums.ProductStatus;
import iuh.backend.models.Product;
import iuh.backend.services.ProductService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ProductModel {
    private final ProductService productService = new ProductService();

    public void insertProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String unit = request.getParameter("unit");
        String manufacturer = request.getParameter("manufacturer");
        String status = request.getParameter("status");

        Product product = new Product(name, description, unit, manufacturer, ProductStatus.valueOf(status));
        productService.insertProduct(product);
        response.sendRedirect("product.jsp");
    }

    public void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        long id = Long.parseLong(request.getParameter("id"));
        productService.updateStatus(id, ProductStatus.TERMINATED);
        response.sendRedirect("product.jsp");
    }

    public void activeProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        long id = Long.parseLong(request.getParameter("id"));
        productService.updateStatus(id, ProductStatus.ACTIVE);
        response.sendRedirect("product.jsp");
    }

    public void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            long id = Long.parseLong(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String unit = request.getParameter("unit");
            String manufacturer = request.getParameter("manufacturer");
            String status = request.getParameter("status");

            Product product = new Product(id, name, description, unit, manufacturer, ProductStatus.valueOf(status));
            boolean updated = productService.updateProduct(product);

            if (updated) {
                response.sendRedirect("product.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Update failed");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product status");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred");
        }
    }




}
