package iuh.backend.services;

import iuh.backend.models.Customer;
import iuh.backend.repositories.CustomerRepository;

import java.util.List;
import java.util.Optional;

public class CustomerService {

    private CustomerRepository customerRepository;

    public CustomerService(){
        customerRepository = new CustomerRepository();
    }

    public List<Customer> getAll() {
        return customerRepository.getAllCustomer();
    }

    public void insertCustomer(Customer customer) {
        customerRepository.insertCustomer(customer);
    }

    public boolean updateCustomer(Customer customer) {
        return customerRepository.updateCustomer(customer);
    }

    public Optional<Customer> findById(long id) {
        return customerRepository.findById(id);
    }

}
