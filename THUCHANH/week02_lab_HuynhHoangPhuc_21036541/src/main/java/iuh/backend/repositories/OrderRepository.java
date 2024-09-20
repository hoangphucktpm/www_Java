package iuh.backend.repositories;

import iuh.backend.models.Order;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Optional;

public class OrderRepository {
    private EntityManager em;
    private EntityTransaction et;

    private final Logger logger = LoggerFactory.getLogger(this.getClass().getName());

    public OrderRepository() {
        em = Persistence.createEntityManagerFactory("MariaBD").createEntityManager();
        et = em.getTransaction();
    }


    public Optional<Order> findById(long id)
    {
        return Optional.ofNullable(em.find(Order.class, id));
    }

    public List<Order> getAllOrder() {
        return em.createQuery("SELECT o FROM Order o JOIN FETCH o.emp JOIN FETCH o.cust", Order.class)
                .getResultList();
    }







}
