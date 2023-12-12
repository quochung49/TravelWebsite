package entity.model;

import java.util.Date;

public class Order {

    private int userId;
    private int orderId;
    private String description;
    private String status;
    private float total;
    private Date orderDate;

    public Order(int userId, int orderId, String description, String status, float total, Date orderDate) {
        this.userId = userId;
        this.orderId = orderId;
        this.description = description;
        this.status = status;
        this.total = total;
        this.orderDate = orderDate;
    }
    
    public Order(int userId, String description, String status, float total, Date orderDate) {
        this.userId = userId;
        this.description = description;
        this.status = status;
        this.total = total;
        this.orderDate = orderDate;
    }
    

    public Order() {
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    @Override
    public String toString() {
        return "Order{" + "userId=" + userId + ", orderId=" + orderId + ", description=" + description + ", status=" + status + ", total=" + total + ", orderDate=" + orderDate + '}';
    }

}
