package com.bookstore.models;

public class Book extends BaseEntity {
    private String name;
    private String isbn;
    private String imageUrl;
    private String category;
    private double price;
    private int inStock;
    private String authorId;

    public Book() {

        super();
    }

    public Book(String name, String isbn, String imageUrl, String category, double price, int inStock, String authorId) {
        super();
        this.name = name;
        this.isbn = isbn;
        this.imageUrl = imageUrl;
        this.category = category;
        this.price = price;
        this.inStock = inStock;
        this.authorId = authorId;
    }

    public Book(String id, String name, String isbn, String imageUrl, String category, double price, int inStock, String authorId) {
        super(id);
        this.name = name;
        this.isbn = isbn;
        this.imageUrl = imageUrl;
        this.category = category;
        this.price = price;
        this.inStock = inStock;
        this.authorId = authorId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getInStock() {
        return inStock;
    }

    public void setInStock(int inStock) {
        this.inStock = inStock;
    }

    public String getAuthorId() {
        return authorId;
    }

    public void setAuthorId(String authorId) {
        this.authorId = authorId;
    }

    @Override
    public String toString() {
        return id + "," + name + "," + isbn + "," + imageUrl + "," + category + "," + price + "," + inStock + "," + authorId;
    }
}