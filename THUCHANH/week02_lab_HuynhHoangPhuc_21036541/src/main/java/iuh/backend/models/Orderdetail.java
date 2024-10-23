package iuh.backend.models;

import jakarta.persistence.*;

@Entity
@Table(name = "orderdetail")
public class Orderdetail {
    @EmbeddedId
    private OrderdetailId id;

    @Column(name = "quantity", nullable = false)
    private Double quantity;

    @Column(name = "price", nullable = false)
    private Double price;

    @Lob
    @Column(name = "note")
    private String note;

    public OrderdetailId getId() {
        return id;
    }

    public void setId(OrderdetailId id) {
        this.id = id;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Orderdetail(OrderdetailId id, Double quantity, Double price, String note) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.note = note;
    }

    public Orderdetail() {
    }

}