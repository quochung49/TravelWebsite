package entity.model;

import java.util.ArrayList;
import java.util.List;

public class OrderDetail {
    private int orderId;
    private List<Item> items;
    private float shipping;
    private float total;

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public float getShipping() {
        return shipping;
    }

    public void setShipping(float shipping) {
        this.shipping = shipping;
    }

    public OrderDetail() {
        this.items = new ArrayList<>();
        this.total = 0.0f;
    }

    public OrderDetail(List<Item> items) {
        this.items = items;
        calculateTotal();
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
        calculateTotal();
    }

    public float getTotal() {
        return total;
    }

    public String formattedTotal() {
        return String.format("%.2f", total);
    }

    public String formattedShipping() {
        return String.format("%.2f", shipping);
    }

    private void calculateTotal() {
        total = 0.0f;
        for (Item item : items) {
            total += item.getTotal();
        }
        total += shipping;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "orderId=" + orderId + ", items=" + items + '}';
    }
    
    
}
