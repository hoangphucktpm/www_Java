package iuh.week02_lab_huynhhoangphuc_21036541.backend.services;

import java.util.List;
import iuh.week02_lab_huynhhoangphuc_21036541.backend.models.Customer;
import iuh.week02_lab_huynhhoangphuc_21036541.backend.repositories.CustomerRepository;


public class CustomerService {
    private CustomerRepository customerRepository;

    public CustomerService() {
        customerRepository = new CustomerRepository();
    }

    public List<Customer> getAll(){
        return customerRepository.getAllCustomer();
    }

    public void create(Customer c){
        customerRepository.add(c);
    }

    public void delete(long id){
        customerRepository.delete(id);
    }

    public void update(Customer c){
        customerRepository.update(c);
    }

    public Customer findById(long id){
        return customerRepository.findById(id);
    }
}