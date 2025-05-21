package com.bookstore.dtos;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

public class BookDTO {
    private String id;

    @NotBlank(message = "Name is required")
    private String name;

    @NotBlank(message = "ISBN is required")
    private String isbn;

    private String imageUrl;

    @NotBlank(message = "Category is required")
    private String category;

    @NotNull(message = "Price is required")
    @Min(value = 0, message = "Price must be non-negative")
    private Double price;

    @NotNull(message = "Stock quantity is required")
    @Min(value = 0, message = "Stock quantity must be non-negative")
    private Integer inStock;

    @NotBlank(message = "Author ID is required")
    private String authorId;

    public BookDTO() {
    }

    public BookDTO(String name, String isbn, String imageUrl, String category, Double price, Integer inStock, String authorId) {
        this.name = name;
        this.isbn = isbn;
        this.imageUrl = imageUrl;
        this.category = category;
        this.price = price;
        this.inStock = inStock;
        this.authorId = authorId;
    }

    public BookDTO(String id, String name, String isbn, String imageUrl, String category, Double price, Integer inStock, String authorId) {
        this.id = id;
        this.name = name;
        this.isbn = isbn;
        this.imageUrl = imageUrl;
        this.category = category;
        this.price = price;
        this.inStock = inStock;
        this.authorId = authorId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getInStock() {
        return inStock;
    }

    public void setInStock(Integer inStock) {
        this.inStock = inStock;
    }

    public String getAuthorId() {
        return authorId;
    }

    public void setAuthorId(String authorId) {
        this.authorId = authorId;
    }
}