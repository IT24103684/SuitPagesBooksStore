package com.bookstore.dtos;

import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderDTO {
    private String id;
    
    @NotBlank(message = "User ID is required")
    private String userId;
    
    @NotBlank(message = "Address is required")
    private String address;
    
    private String status;
    
    private LocalDateTime orderDate;
    
    @Valid
    private List<OrderItemDTO> items = new ArrayList<>();

    public OrderDTO() {
    }

    public OrderDTO(String userId, String address) {
        this.userId = userId;
        this.address = address;
        this.status = "PENDING";
        this.orderDate = LocalDateTime.now();
    }

    public OrderDTO(String id, String userId, String address, String status, LocalDateTime orderDate, List<OrderItemDTO> items) {
        this.id = id;
        this.userId = userId;
        this.address = address;
        this.status = status;
        this.orderDate = orderDate;
        this.items = items;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public List<OrderItemDTO> getItems() {
        return items;
    }

    public void setItems(List<OrderItemDTO> items) {
        this.items = items;
    }

    public static class OrderItemDTO {
        @NotBlank(message = "Book ID is required")
        private String bookId;
        
        @NotNull(message = "Quantity is required")
        @Min(value = 1, message = "Quantity must be at least 1")
        private Integer quantity;
        
        @NotNull(message = "Price is required")
        @Min(value = 0, message = "Price must be non-negative")
        private Double price;

        public OrderItemDTO() {
        }

        public OrderItemDTO(String bookId, Integer quantity, Double price) {
            this.bookId = bookId;
            this.quantity = quantity;
            this.price = price;
        }

        public String getBookId() {
            return bookId;
        }

        public void setBookId(String bookId) {
            this.bookId = bookId;
        }

        public Integer getQuantity() {
            return quantity;
        }

        public void setQuantity(Integer quantity) {
            this.quantity = quantity;
        }

        public Double getPrice() {
            return price;
        }

        public void setPrice(Double price) {
            this.price = price;
        }
    }
}