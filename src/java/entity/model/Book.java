package entity.model;

import java.io.Serializable;

public class Book implements Serializable {

    private int id;
    private String title;
    private String author;
    private String description;
    private float price;
    private int quantityInStock;
    private String imageURL;
    private Category category;

    public Book() {

    }

    public Book(int id, String title, String author, String description, float price, int quantityInStock, String imgUrl) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.description = description;
        this.price = price;
        this.quantityInStock = quantityInStock;
        this.imageURL = imgUrl;
    }

    public Book(String title, String author, String description, float price, int quantityInStock, String imgUrl) {
        this.title = title;
        this.author = author;
        this.description = description;
        this.price = price;
        this.quantityInStock = quantityInStock;
        this.imageURL = imgUrl;
    }

    public Book(int id, String title, String author, String description, float price, int quantityInStock, String imgUrl, Category category) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.description = description;
        this.price = price;
        this.quantityInStock = quantityInStock;
        this.imageURL = imgUrl;
        this.category = category;
    }

    public Book(String title, String author, String description, float price, int quantityInStock, String imgUrl, Category category) {
        this.title = title;
        this.author = author;
        this.description = description;
        this.price = price;
        this.quantityInStock = quantityInStock;
        this.imageURL = imgUrl;
        this.category = category;
    }

    // Getters and setters for attributes
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getQuantityInStock() {
        return quantityInStock;
    }

    public void setQuantityInStock(int quantityInStock) {
        this.quantityInStock = quantityInStock;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Book{" + "id=" + id + ", title=" + title + ", author=" + author + ", description=" + description + ", price=" + price + ", quantityInStock=" + quantityInStock + ", imageURL=" + imageURL + ", category=" + category.getName() + '}';
    }

}
