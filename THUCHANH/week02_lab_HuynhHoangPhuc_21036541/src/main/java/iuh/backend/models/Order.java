package iuh.backend.models;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.sql.Timestamp;

@Entity
@Table(name = "orders")
//@NamedQueries({
//        @NamedQuery(
//                name = "Order.getAllOrdersByEmAndDate",
//                query = "SELECT o FROM Order o WHERE o.employee = :employee AND o.orderDate >= :startDate AND o.orderDate <= :endDate"
//        ),
//})
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id", nullable = false)
    private Long id;

    @Column(name = "order_date", nullable = false)
    private Timestamp orderDate; // Thay đổi từ Instant sang Timestamp

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "emp_id", nullable = false)
    private Employee emp;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "cust_id", nullable = false)
    private Customer cust;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Timestamp getOrderDate() {
        return orderDate; // Trả về kiểu Timestamp
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate; // Nhận kiểu Timestamp
    }

    public Employee getEmp() {
        return emp;
    }

    public void setEmp(Employee emp) {
        this.emp = emp;
    }

    public Customer getCust() {
        return cust;
    }

    public void setCust(Customer cust) {
        this.cust = cust;
    }

    public Order() {
    }

    public Order(Timestamp orderDate, Employee emp, Customer cust) {
        this.orderDate = orderDate;
        this.emp = emp;
        this.cust = cust;
    }
}
