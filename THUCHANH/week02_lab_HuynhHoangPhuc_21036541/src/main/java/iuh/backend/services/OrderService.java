package iuh.backend.services;

import iuh.backend.models.Order;
import iuh.backend.repositories.OrderRepository;

import java.util.List;
import java.util.Optional;

public class OrderService {

    private OrderRepository orderRepository;

    public OrderService(){
        orderRepository = new OrderRepository();
    }

    public List<Order> getAll() {
        return orderRepository.getAllOrder();
    }

    public Optional<Order> findById(long id) {
        return orderRepository.findById(id);
    }

}
