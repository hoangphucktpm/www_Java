package iuh.frontend.model;

import iuh.backend.models.Customer;
import iuh.backend.services.CustomerService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class CustomerModel {
    private final CustomerService customerService = new CustomerService();

    public void insertCust(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");

        Customer customer = new Customer(name, email, phone, address);
        customerService.insertCustomer(customer);
        resp.sendRedirect("Customers.jsp");
    }

    public List<Customer> getAllCustomers() {
        return customerService.getAll();
    }
}
