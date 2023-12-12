package entity.model;

import java.util.ArrayList;

public class Cart {

    private ArrayList<Item> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public ArrayList<Item> getItems() {
        return items;
    }

    public void setItems(ArrayList<Item> items) {
        this.items = items;
    }

    public int getCount() {
        return items.size();
    }

    public void addItem(Item item) {
        items.add(item);
    }

    public void removeItem(Item item) {
        items.remove(item);
    }

    public float getTotalAmount() {
        float result = 0;

        for (Item item : items) {
            result += item.getTotal();
        }

        return result;
    }
    
    public String getDescription(){
       String result = "";

        for (Item item : items) {
            result += item.getBook().getTitle() + "x" + item.getQuantity()+ ", ";
        }

        return result; 
    }

    @Override
    public String toString() {
        return "Cart{" + "items=" + items + '}';
    }

}
